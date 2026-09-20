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

    return Transform.translate(
      offset: Offset(nudge, 0),
      child: Column(
        children: [
          Text(
            label.toUpperCase(),
            textAlign: TextAlign.center,
            style: labelStyle,
          ),
          SizedBox(height: labelToTitleGap),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Color.lerp(
                    titleColor ?? AppColors.accentLavender,
                    Colors.white,
                    0.04 * breathe,
                  ),
                  fontWeight: FontWeight.w800,
                  fontSize: titleSize,
                ),
          ),
        ],
      ),
    );
  }
}
