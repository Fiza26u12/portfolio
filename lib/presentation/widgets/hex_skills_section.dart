import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/models/skill_item.dart';
import '../animation/portfolio_motion.dart';

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    return Path()
      ..moveTo(w * 0.25, 0)
      ..lineTo(w * 0.75, 0)
      ..lineTo(w, h * 0.5)
      ..lineTo(w * 0.75, h)
      ..lineTo(w * 0.25, h)
      ..lineTo(0, h * 0.5)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Decorative arc only (no proficiency / percent).
class _AccentArcPainter extends CustomPainter {
  _AccentArcPainter({
    required this.color,
    required this.rotation,
  });

  final Color color;
  final double rotation;

  static const double _sweep = 4.3;

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.shortestSide * 0.36;
    final rect = Rect.fromCircle(center: c, radius: r);
    final track = Paint()
      ..color = color.withValues(alpha: 0.16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6;
    final arc = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6
      ..strokeCap = StrokeCap.round;

    final start = -math.pi / 2 + rotation * math.pi * 2;
    canvas.drawArc(rect, start, math.pi * 2, false, track);
    canvas.drawArc(rect, start, _sweep, false, arc);
  }

  @override
  bool shouldRepaint(covariant _AccentArcPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.rotation != rotation;
  }
}

class HexSkillBadge extends StatelessWidget {
  const HexSkillBadge({
    super.key,
    required this.skill,
    required this.width,
    required this.ringColor,
    required this.skillIndex,
  });

  final SkillItem skill;
  final double width;
  final Color ringColor;
  final int skillIndex;

  double get _height => width * 0.866;

  @override
  Widget build(BuildContext context) {
    final t = PortfolioMotion.phaseOf(context);
    final bob = math.sin((t * math.pi * 2) + skillIndex * 0.95) * 3.2;
    final arcTurn = t + skillIndex * 0.08;

    return Transform.translate(
      offset: Offset(0, bob),
      child: SizedBox(
        width: width,
        height: _height,
        child: ClipPath(
          clipper: HexagonClipper(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ColoredBox(color: AppColors.aboutCardSurface),
              CustomPaint(
                painter: _AccentArcPainter(color: ringColor, rotation: arcTurn),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    skill.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                          fontSize: width < 100 ? 12.5 : 14,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Skill grid: six items use a flat 3×2 layout with aligned columns; other counts use rows of three or pairs on narrow screens.
class HexSkillsHoneycomb extends StatelessWidget {
  const HexSkillsHoneycomb({super.key, required this.skills});

  final List<SkillItem> skills;

  Color _ringColor(SkillItem s, int index) {
    const fallback = [
      Color(0xFFFF6B9D),
      Color(0xFF2DD4BF),
      Color(0xFFFACC15),
      Color(0xFF60A5FA),
      Color(0xFFA78BFA),
      Color(0xFFFF8D6B),
    ];
    return s.ringColor ?? fallback[index % fallback.length];
  }

  @override
  Widget build(BuildContext context) {
    final list = skills;
    if (list.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth;
        final narrow = maxW < 520;

        // Six skills: always a flat 3×2 grid (columns line up), wider gaps on desktop.
        if (list.length == 6) {
          final gap = narrow ? 12.0 : 32.0;
          final rowGap = narrow ? 20.0 : 32.0;
          final cellW = ((maxW - gap * 2) / 3).clamp(narrow ? 72.0 : 84.0, narrow ? 108.0 : 132.0);
          return _sixWideFlat(list, cellW, gap, rowGap, _ringColor);
        }

        final gap = narrow ? 18.0 : 22.0;
        final rowGap = narrow ? 16.0 : 20.0;

        if (narrow) {
          final cellW = ((maxW - gap) / 2).clamp(84.0, 120.0);
          return _narrowPairs(list, cellW, gap, rowGap, _ringColor);
        }

        final cellW = ((maxW - gap * 2) / 3).clamp(92.0, 128.0);
        if (list.length >= 8) {
          return _eightWide(list, cellW, gap, rowGap, _ringColor);
        }
        return _genericGrid(list, cellW, gap, rowGap, _ringColor);
      },
    );
  }

  Widget _hex(SkillItem s, int index, double cellW, Color Function(SkillItem, int) ring) {
    return HexSkillBadge(
      skill: s,
      width: cellW,
      ringColor: ring(s, index),
      skillIndex: index,
    );
  }

  /// Two rows of three, same column alignment (no honeycomb offset).
  Widget _sixWideFlat(
    List<SkillItem> list,
    double cellW,
    double gap,
    double rowGap,
    Color Function(SkillItem, int) ring,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _hex(list[0], 0, cellW, ring),
            SizedBox(width: gap),
            _hex(list[1], 1, cellW, ring),
            SizedBox(width: gap),
            _hex(list[2], 2, cellW, ring),
          ],
        ),
        SizedBox(height: rowGap),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _hex(list[3], 3, cellW, ring),
            SizedBox(width: gap),
            _hex(list[4], 4, cellW, ring),
            SizedBox(width: gap),
            _hex(list[5], 5, cellW, ring),
          ],
        ),
      ],
    );
  }

  Widget _eightWide(
    List<SkillItem> list,
    double cellW,
    double gap,
    double rowGap,
    Color Function(SkillItem, int) ring,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _hex(list[0], 0, cellW, ring),
            SizedBox(width: gap),
            _hex(list[1], 1, cellW, ring),
            SizedBox(width: gap),
            _hex(list[2], 2, cellW, ring),
          ],
        ),
        SizedBox(height: rowGap),
        Transform.translate(
          offset: Offset((cellW + gap) * 0.5, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _hex(list[3], 3, cellW, ring),
              SizedBox(width: gap),
              _hex(list[4], 4, cellW, ring),
              SizedBox(width: gap),
              _hex(list[5], 5, cellW, ring),
            ],
          ),
        ),
        SizedBox(height: rowGap),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _hex(list[6], 6, cellW, ring),
            SizedBox(width: gap),
            _hex(list[7], 7, cellW, ring),
          ],
        ),
      ],
    );
  }

  Widget _narrowPairs(
    List<SkillItem> list,
    double cellW,
    double gap,
    double rowGap,
    Color Function(SkillItem, int) ring,
  ) {
    final rows = <Widget>[];
    for (var i = 0; i < list.length; i += 2) {
      final left = (i ~/ 2).isOdd ? (cellW + gap) * 0.18 : 0.0;
      final a = list[i];
      final b = i + 1 < list.length ? list[i + 1] : null;
      rows.add(
        Padding(
          padding: EdgeInsets.only(
            bottom: i + 2 < list.length ? rowGap : 0,
            left: left,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _hex(a, i, cellW, ring),
              if (b != null) ...[
                SizedBox(width: gap),
                _hex(b, i + 1, cellW, ring),
              ],
            ],
          ),
        ),
      );
    }
    return Column(mainAxisSize: MainAxisSize.min, children: rows);
  }

  Widget _genericGrid(
    List<SkillItem> list,
    double cellW,
    double gap,
    double rowGap,
    Color Function(SkillItem, int) ring,
  ) {
    final rows = <Widget>[];
    for (var i = 0; i < list.length; i += 3) {
      final chunk = list.skip(i).take(3).toList();
      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: i + 3 < list.length ? rowGap : 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var j = 0; j < chunk.length; j++) ...[
                if (j > 0) SizedBox(width: gap),
                _hex(chunk[j], i + j, cellW, ring),
              ],
            ],
          ),
        ),
      );
    }
    return Column(mainAxisSize: MainAxisSize.min, children: rows);
  }
}
