import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../../data/portfolio_content.dart';
import '../animation/portfolio_motion.dart';
import 'gradient_pill_button.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onGetInTouch,
  });

  final VoidCallback onViewWork;
  final VoidCallback onGetInTouch;

  @override
  Widget build(BuildContext context) {
    final nameSize = context.isMobile ? 38.0 : (context.isTablet ? 56.0 : 72.0);
    final t = PortfolioMotion.phaseOf(context);
    final floatY = math.sin(t * math.pi * 2) * 5;
    final glow = 0.5 + 0.5 * math.sin(t * math.pi * 2 * 1.4);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding(context),
        heroTopPadding(context),
        horizontalPadding(context),
        heroBottomPadding(context),
      ),
      child: Column(
        children: [
          Transform.translate(
            offset: Offset(0, floatY),
            child: Transform.scale(
              scale: 1.0 + 0.012 * math.sin(t * math.pi * 2 * 0.65),
              alignment: Alignment.center,
              child: Text(
                PortfolioContent.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  color: AppColors.accentLavender,
                  fontSize: nameSize,
                  shadows: [
                    Shadow(
                      color: AppColors.buttonGradientStart.withValues(
                        alpha: 0.25 + 0.2 * glow,
                      ),
                      blurRadius: 28 + 12 * glow,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Transform.translate(
            offset: Offset(4 * math.sin(t * math.pi * 2 * 0.5), 0),
            child: Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.95),
                  height: 1.25,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  const TextSpan(text: PortfolioContent.heroTaglineLead),
                  TextSpan(
                    text: PortfolioContent.heroTaglineHighlight,
                    style: TextStyle(
                      color: Color.lerp(
                        AppColors.accentLavender,
                        AppColors.buttonGradientStart,
                        0.35 + 0.35 * math.sin(t * math.pi * 2),
                      ),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Opacity(
            opacity:
                0.94 + 0.06 * (0.5 + 0.5 * math.sin(t * math.pi * 2 * 0.8)),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 860),
              child: Text(
                PortfolioContent.heroDescription,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.82),
                  height: 1.55,
                ),
              ),
            ),
          ),
          SizedBox(height: heroCtaRowVerticalGap(context)),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 14,
            runSpacing: 14,
            children: [
              GradientPillButton(label: 'View My Work', onPressed: onViewWork),
              OutlinedPillButton(
                label: 'Get in Touch',
                onPressed: onGetInTouch,
              ),
            ],
          ),
          SizedBox(height: heroCtaRowVerticalGap(context)),
          const _HeroContactRow(),
        ],
      ),
    );
  }
}

class _HeroContactRow extends StatelessWidget {
  const _HeroContactRow();

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.bodyMuted,
      fontWeight: FontWeight.w600,
    );

    final children = <Widget>[
      _ContactChip(
        icon: Icons.location_on_outlined,
        iconColor: AppColors.iconLocation,
        text: PortfolioContent.location,
        style: style,
        slot: 0,
      ),
      _ContactChip(
        icon: Icons.mail_outline_rounded,
        iconColor: AppColors.iconEmail,
        text: PortfolioContent.email,
        style: style,
        slot: 1,
      ),
      _ContactChip(
        icon: Icons.phone_iphone_rounded,
        iconColor: AppColors.iconPhone,
        text: PortfolioContent.phoneDisplay,
        style: style,
        slot: 2,
      ),
    ];

    if (context.isMobile) {
      return Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i != 0) const SizedBox(height: 10),
            children[i],
          ],
        ],
      );
    }

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 18,
      runSpacing: 10,
      children: children,
    );
  }
}

class _ContactChip extends StatelessWidget {
  const _ContactChip({
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.style,
    required this.slot,
  });

  final IconData icon;
  final Color iconColor;
  final String text;
  final TextStyle? style;
  final int slot;

  @override
  Widget build(BuildContext context) {
    final t = PortfolioMotion.phaseOf(context);
    final w = math.sin((t + slot * 0.19) * math.pi * 2) * 2.0;

    return Transform.translate(
      offset: Offset(0, w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 8),
          Flexible(
            child: Text(text, textAlign: TextAlign.center, style: style),
          ),
        ],
      ),
    );
  }
}
