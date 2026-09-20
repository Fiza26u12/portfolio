import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/portfolio_content.dart';
import '../animation/portfolio_motion.dart';
import 'portfolio_glass_panel.dart';

class EducationCard extends StatelessWidget {
  const EducationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioGlassPanel(
      borderRadius: 22,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 560;

            final left = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  PortfolioContent.degreeTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  PortfolioContent.institutionName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.bodyText,
                        height: 1.35,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  PortfolioContent.institutionLocation,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.bodyMuted,
                        height: 1.35,
                      ),
                ),
              ],
            );

            final t = PortfolioMotion.phaseOf(context);
            final badgePulse = 1.0 + 0.04 * math.sin(t * math.pi * 2);

            final badge = Transform.scale(
              scale: badgePulse,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: AppColors.primaryButtonGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.buttonGradientStart.withValues(
                        alpha: 0.35 + 0.2 * (0.5 + 0.5 * math.sin(t * math.pi * 2 * 1.05)),
                      ),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    PortfolioContent.educationDateRange,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
              ),
            );

            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  left,
                  const SizedBox(height: 14),
                  badge,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: left),
                const SizedBox(width: 12),
                badge,
              ],
            );
          },
        ),
      ),
    );
  }
}
