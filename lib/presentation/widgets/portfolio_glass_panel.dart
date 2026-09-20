import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

/// Unified dark glass card used across About, Skills, Experience, Projects, Education, Contact.
class PortfolioGlassPanel extends StatelessWidget {
  const PortfolioGlassPanel({
    super.key,
    required this.borderRadius,
    required this.child,
    this.minHeight,
    this.highlighted = false,
  });

  final double borderRadius;
  final Widget child;
  final double? minHeight;

  /// Raises the rim and glow, used for pointer hover on interactive cards.
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final panel = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.lerp(
              AppColors.panelSurfaceTop,
              AppColors.buttonGradientStart,
              highlighted ? 0.12 : 0.0,
            )!,
            AppColors.panelSurfaceBottom,
          ],
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: highlighted
              ? AppColors.buttonGradientStart.withValues(alpha: 0.62)
              : AppColors.aboutCardEdgeLight.withValues(alpha: 0.22),
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
            color: Colors.black.withValues(alpha: highlighted ? 0.52 : 0.42),
            blurRadius: highlighted ? 26 : 12,
            offset: Offset(0, highlighted ? 14 : 5),
          ),
          if (highlighted)
            BoxShadow(
              color: AppColors.buttonGradientEnd.withValues(alpha: 0.28),
              blurRadius: 34,
              spreadRadius: -6,
              offset: const Offset(0, 12),
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
