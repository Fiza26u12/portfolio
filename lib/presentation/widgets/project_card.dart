import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_colors.dart';
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

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    HapticFeedback.lightImpact();
    await _scaleController.forward();
    await _scaleController.reverse();
    final raw = widget.item.externalUrl;
    if (raw == null || raw.isEmpty) return;
    final uri = Uri.tryParse(raw);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final link = widget.item.externalUrl;
    final hasLink = link != null && link.isNotEmpty;
    final t = PortfolioMotion.phaseOf(context);
    final driftY = math.sin((t * math.pi * 2) + widget.motionSlot * 0.31) * 3.5;

    return Semantics(
      container: !hasLink,
      button: hasLink,
      label: widget.item.title,
      hint: hasLink ? 'Opens project link' : null,
      child: Transform.translate(
        offset: Offset(0, driftY),
        child: ScaleTransition(
          scale: _scale,
          alignment: Alignment.center,
          child: SizedBox(
            width: double.infinity,
            height: widget.cardHeight,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: _onTap,
                child: PortfolioGlassPanel(
                  borderRadius: 20,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.item.iconEmoji, style: const TextStyle(fontSize: 34)),
                        const SizedBox(height: 12),
                        Text(
                          widget.item.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.item.subtitle,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.accentLavender.withValues(alpha: 0.95),
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Text(
                            widget.item.description,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.bodyText,
                                  height: 1.5,
                                ),
                          ),
                        ),
                        SizedBox(
                          height: 26,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: hasLink
                                ? Text(
                                    'Explore →',
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                          color: AppColors.accentLavender,
                                          fontWeight: FontWeight.w800,
                                        ),
                                  )
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
    );
  }
}
