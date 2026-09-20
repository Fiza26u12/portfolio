import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../animation/portfolio_motion.dart';
import 'portfolio_glass_panel.dart';

class AboutBioCard extends StatelessWidget {
  const AboutBioCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = PortfolioMotion.phaseOf(context);
    final lift = math.sin(t * math.pi * 2 * 0.55) * 2.0;

    return Transform.translate(
      offset: Offset(0, lift),
      child: Opacity(
        opacity: 0.94 + 0.06 * (0.5 + 0.5 * math.sin(t * math.pi * 2 * 0.7)),
        child: PortfolioGlassPanel(
          borderRadius: 16,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 38),
            child: Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.bodyText.withValues(alpha: 0.92),
                      height: 1.66,
                    ),
                children: const [
                  TextSpan(text: "I'm a passionate "),
                  TextSpan(
                    text: 'Flutter Developer',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' proficient in Flutter, Firebase, RESTful APIs and backend integration. Skilled in using ',
                  ),
                  TextSpan(
                    text: 'GetX',
                    style: TextStyle(
                      color: AppColors.aboutBioHighlight,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' for state management, with a track record of optimising real-time features and automating workflows to deliver fast, reliable mobile apps.',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
