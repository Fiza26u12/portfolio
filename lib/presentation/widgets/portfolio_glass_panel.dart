import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

/// Unified dark glass card used across About, Skills, Experience, Projects, Education, Contact.
class PortfolioGlassPanel extends StatelessWidget {
  const PortfolioGlassPanel({
    super.key,
    required this.borderRadius,
    required this.child,
    this.minHeight,
  });

  final double borderRadius;
  final Widget child;
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    final panel = DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.aboutCardSurface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: AppColors.aboutCardEdgeLight.withValues(alpha: 0.22),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.aboutCardGlowAccent.withValues(alpha: 0.22),
            blurRadius: 6,
            spreadRadius: -2,
            offset: const Offset(-1, -1),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.42),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );

    if (minHeight != null) {
      return ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight!),
        child: panel,
      );
    }
    return panel;
  }
}
