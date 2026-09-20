import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../../data/models/experience_item.dart';
import '../animation/portfolio_motion.dart';
import 'experience_card.dart';

class ExperienceTimeline extends StatelessWidget {
  const ExperienceTimeline({super.key, required this.items});

  final List<ExperienceItem> items;

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return _MobileTimeline(items: items);
    }
    return _DesktopAlternatingTimeline(items: items);
  }
}

class _MobileTimeline extends StatelessWidget {
  const _MobileTimeline({required this.items});

  final List<ExperienceItem> items;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 10,
          top: 0,
          bottom: 0,
          child: Container(
            width: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.buttonGradientStart.withValues(alpha: 0.12),
                  AppColors.accentLavender.withValues(alpha: 0.55),
                  AppColors.buttonGradientStart.withValues(alpha: 0.12),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            for (var i = 0; i < items.length; i++) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 22,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: _TimelineDot(),
                    ),
                  ),
                  Expanded(child: ExperienceCard(item: items[i], motionSlot: i)),
                ],
              ),
              if (i != items.length - 1) const SizedBox(height: 18),
            ],
          ],
        ),
      ],
    );
  }
}

class _DesktopAlternatingTimeline extends StatelessWidget {
  const _DesktopAlternatingTimeline({required this.items});

  final List<ExperienceItem> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final midX = constraints.maxWidth / 2;
        const laneWidth = 2.0;

        return Stack(
          children: [
            Positioned(
              left: midX - laneWidth / 2,
              top: 0,
              bottom: 0,
              child: Container(
                width: laneWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.buttonGradientStart.withValues(alpha: 0.12),
                      AppColors.accentLavender.withValues(alpha: 0.55),
                      AppColors.buttonGradientStart.withValues(alpha: 0.12),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                for (var i = 0; i < items.length; i++) ...[
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: items[i].alignLeft
                                    ? Padding(
                                        padding: const EdgeInsets.only(right: 34),
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: (constraints.maxWidth / 2) - 40,
                                          ),
                                          child: ExperienceCard(item: items[i], motionSlot: i),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: !items[i].alignLeft
                                    ? Padding(
                                        padding: const EdgeInsets.only(left: 34),
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: (constraints.maxWidth / 2) - 40,
                                          ),
                                          child: ExperienceCard(item: items[i], motionSlot: i),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: midX - 8,
                        top: 34,
                        child: _TimelineDot(),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ],
        );
      },
    );
  }
}

class _TimelineDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = PortfolioMotion.phaseOf(context);
    final pulse = 1.0 + 0.14 * (0.5 + 0.5 * math.sin(t * math.pi * 2 * 1.2));

    return Transform.scale(
      scale: pulse,
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.backgroundDeep,
          border: Border.all(color: AppColors.accentLavender, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.buttonGradientStart.withValues(alpha: 0.45 + 0.2 * pulse),
              blurRadius: 10 + 10 * pulse,
              spreadRadius: 0.5 * pulse,
            ),
          ],
        ),
      ),
    );
  }
}
