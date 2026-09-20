import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/app_colors.dart';
import '../../core/link_launcher.dart';
import '../../data/models/project_item.dart';
import '../animation/portfolio_motion.dart';
import 'portfolio_glass_panel.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.item,
    required this.cardHeight,
    this.motionSlot = 0,
  });

  final ProjectItem item;
  final double cardHeight;
  final int motionSlot;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 140),
  );

  late final Animation<double> _scale = Tween<double>(begin: 1.0, end: 1.06).animate(
    CurvedAnimation(parent: _scaleController, curve: Curves.easeOutCubic),
  );

  bool _hovered = false;

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTap() {
    // Launch first: Safari blocks the new tab if `window.open` runs after an
    // await, which is why the press animation is queued afterwards.
    LinkLauncher.openExternal(widget.item.externalUrl);
    HapticFeedback.lightImpact();
    _playPressAnimation();
  }

  Future<void> _playPressAnimation() async {
    await _scaleController.forward();
    if (!mounted) return;
    await _scaleController.reverse();
  }

  void _setHovered(bool value) {
    if (_hovered == value) return;
    setState(() => _hovered = value);
  }

  @override
  Widget build(BuildContext context) {
    final link = widget.item.externalUrl;
    final hasLink = link != null && link.isNotEmpty;
    final t = PortfolioMotion.phaseOf(context);
    final driftY = math.sin((t * math.pi * 2) + widget.motionSlot * 0.31) * 3.5;
    final hoverLift = hasLink && _hovered ? -8.0 : 0.0;

    return Semantics(
      container: !hasLink,
      button: hasLink,
      label: widget.item.title,
      hint: hasLink ? 'Opens project link' : null,
      child: AnimatedSlide(
        offset: Offset(0, hoverLift / widget.cardHeight),
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: Transform.translate(
          offset: Offset(0, driftY),
          child: ScaleTransition(
            scale: _scale,
            alignment: Alignment.center,
            child: SizedBox(
              width: double.infinity,
              height: widget.cardHeight,
              child: MouseRegion(
                cursor: hasLink ? SystemMouseCursors.click : MouseCursor.defer,
                onEnter: (_) => _setHovered(true),
                onExit: (_) => _setHovered(false),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: hasLink ? _onTap : null,
                    child: PortfolioGlassPanel(
                      borderRadius: 20,
                      highlighted: hasLink && _hovered,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _IconBadge(emoji: widget.item.iconEmoji),
                            const SizedBox(height: 14),
                            Text(
                              widget.item.title,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    height: 1.15,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.item.subtitle,
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppColors.accentLavender.withValues(alpha: 0.95),
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.2,
                                  ),
                            ),
                            const SizedBox(height: 14),
                            Expanded(
                              child: Text(
                                widget.item.description,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.bodyText.withValues(alpha: 0.86),
                                      height: 1.55,
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: hasLink
                                    ? _ExplorePill(active: _hovered)
                                    : const SizedBox.shrink(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Rounded tile behind the project emoji so every card starts on the same grid.
class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.emoji});

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.buttonGradientStart.withValues(alpha: 0.14),
        border: Border.all(
          color: AppColors.buttonGradientStart.withValues(alpha: 0.28),
        ),
      ),
      child: Text(emoji, style: const TextStyle(fontSize: 24)),
    );
  }
}

class _ExplorePill extends StatelessWidget {
  const _ExplorePill({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: AppColors.buttonGradientStart.withValues(alpha: active ? 0.22 : 0.10),
        border: Border.all(
          color: AppColors.buttonGradientStart.withValues(alpha: active ? 0.7 : 0.34),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Explore',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.accentLavender,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(width: 6),
          AnimatedSlide(
            offset: Offset(active ? 0.18 : 0, 0),
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            child: Icon(
              Icons.arrow_outward_rounded,
              size: 16,
              color: AppColors.accentLavender,
            ),
          ),
        ],
      ),
    );
  }
}
