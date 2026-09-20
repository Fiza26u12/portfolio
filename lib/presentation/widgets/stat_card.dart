import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/models/stat_item.dart';
import '../animation/portfolio_motion.dart';
import 'portfolio_glass_panel.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.item,
    this.motionSlot = 0,
  });

  final StatItem item;
  final int motionSlot;

  @override
  Widget build(BuildContext context) {
    final t = PortfolioMotion.phaseOf(context);
    final wave = math.sin((t + motionSlot * 0.21) * math.pi * 2);
    final bob = wave * 4.0;
    final scale = 1.0 + wave * 0.035;

    return Transform.translate(
      offset: Offset(0, bob),
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.center,
        child: PortfolioGlassPanel(
          borderRadius: 16,
          minHeight: 220,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 34),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.emoji,
                  style: TextStyle(
                    fontSize: 34,
                    height: 1.1,
                    color: item.emojiColor ?? AppColors.aboutStatEmoji,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  item.value,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.accentLavender,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  item.label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.bodyMuted,
                        height: 1.3,
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
