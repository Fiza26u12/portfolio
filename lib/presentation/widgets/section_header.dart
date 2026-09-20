import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../animation/portfolio_motion.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.labelToTitleGap = 12,
    this.titleColor,
    this.labelLetterSpacing = 6,
  });

  final String label;
  final String title;
  final double labelToTitleGap;
  final Color? titleColor;
  final double labelLetterSpacing;

  @override
  Widget build(BuildContext context) {
    final t = PortfolioMotion.phaseOf(context);
    final breathe = 0.5 + 0.5 * math.sin(t * math.pi * 2 * 0.9);
    final nudge = math.sin(t * math.pi * 2 * 0.45) * 3.0;

    final labelStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColors.accentLavender.withValues(alpha: 0.82 + 0.14 * breathe),
          letterSpacing: labelLetterSpacing,
          fontWeight: FontWeight.w600,
        );

    final titleSize = context.isMobile ? 30.0 : 38.0;
    final baseTitleColor = titleColor ?? AppColors.accentLavender;

    return Transform.translate(
      offset: Offset(nudge, 0),
      child: Column(
        children: [
          _LabelChip(label: label.toUpperCase(), style: labelStyle),
          SizedBox(height: labelToTitleGap),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Color.lerp(baseTitleColor, Colors.white, 0.18 * breathe)!,
                AppColors.buttonGradientStart,
              ],
              stops: const [0.0, 0.55, 1.0],
            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: titleSize,
                    height: 1.15,
                  ),
            ),
          ),
          SizedBox(height: context.isMobile ? 12 : 14),
          _TitleUnderline(breathe: breathe),
        ],
      ),
    );
  }
}

/// Pill behind the small section label so each section starts with a marker.
class _LabelChip extends StatelessWidget {
  const _LabelChip({required this.label, required this.style});

  final String label;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: AppColors.buttonGradientStart.withValues(alpha: 0.10),
        border: Border.all(
          color: AppColors.buttonGradientStart.withValues(alpha: 0.30),
        ),
      ),
      child: Text(label, textAlign: TextAlign.center, style: style),
    );
  }
}

class _TitleUnderline extends StatelessWidget {
  const _TitleUnderline({required this.breathe});

  final double breathe;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56 + 10 * breathe,
      height: 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        gradient: AppColors.primaryButtonGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonGradientStart.withValues(alpha: 0.45),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
