import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/models/experience_item.dart';
import '../animation/portfolio_motion.dart';
import 'portfolio_glass_panel.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({
    super.key,
    required this.item,
    this.motionSlot = 0,
  });

  final ExperienceItem item;
  final int motionSlot;

  @override
  Widget build(BuildContext context) {
    final t = PortfolioMotion.phaseOf(context);
    final sway = math.sin((t + motionSlot * 0.13) * math.pi * 2) * 2.2;

    return Transform.translate(
      offset: Offset(sway, 0),
      child: Transform.scale(
        scale: 1.0 + 0.006 * math.sin((t + motionSlot * 0.09) * math.pi * 2),
        alignment: Alignment.center,
        child: PortfolioGlassPanel(
          borderRadius: 18,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.dateRange,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.accentLavender.withValues(alpha: 0.95),
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.company,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.accentLavender.withValues(alpha: 0.85),
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 12),
                ...item.bullets.map(
                  (b) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Transform.rotate(
                            angle: 0.12 * math.sin((t + motionSlot * 0.11) * math.pi * 2),
                            child: Icon(
                              Icons.arrow_right_rounded,
                              size: 18,
                              color: AppColors.buttonGradientStart.withValues(alpha: 0.95),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            b,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.bodyText,
                                  height: 1.45,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
