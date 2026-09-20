import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../animation/portfolio_motion.dart';

class AppGradientBackground extends StatelessWidget {
  const AppGradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final t = PortfolioMotion.phaseOf(context);
    final ox = math.sin(t * math.pi * 2) * 0.1;
    final oy = math.cos(t * math.pi * 2 * 0.85) * 0.07;
    final radius = 1.12 + 0.05 * math.sin(t * math.pi * 2 * 1.2);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(ox, -0.28 + oy),
          radius: radius,
          colors: [
            Color.lerp(
              const Color(0xFF5B21B6),
              AppColors.buttonGradientStart,
              0.12 + 0.1 * math.sin(t * math.pi * 2 * 0.9),
            )!,
            AppColors.radialGlow,
            AppColors.scaffold,
            AppColors.backgroundDeep,
            Colors.black,
          ],
          stops: [
            0.0,
            0.12 + 0.02 * math.cos(t * math.pi * 2),
            0.32,
            0.58,
            1.0,
          ],
        ),
      ),
    );
  }
}
