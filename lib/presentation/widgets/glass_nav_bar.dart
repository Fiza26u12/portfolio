import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../animation/portfolio_motion.dart';

typedef NavCallback = void Function();

class GlassNavBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassNavBar({
    super.key,
    required this.onLogoTap,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onSkillsTap,
    required this.onProjectsTap,
    required this.onContactTap,
    required this.onHireMeTap,
    required this.onOpenDrawer,
  });

  final NavCallback onLogoTap;
  final NavCallback onHomeTap;
  final NavCallback onAboutTap;
  final NavCallback onSkillsTap;
  final NavCallback onProjectsTap;
  final NavCallback onContactTap;
  final NavCallback onHireMeTap;
  final NavCallback onOpenDrawer;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final showDesktopLinks = context.isDesktop;
    final t = PortfolioMotion.phaseOf(context);
    final rim = 0.28 + 0.18 * (0.5 + 0.5 * math.sin(t * math.pi * 2));

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.glassFill,
            border: Border(
              bottom: BorderSide(color: AppColors.cardBorder.withValues(alpha: rim)),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding(context),
                vertical: 10,
              ),
              child: Row(
                children: [
                  TextButton(
                    onPressed: onLogoTap,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.navLogo,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    child: Text(
                      'FS.',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                            color: AppColors.navLogo,
                          ),
                    ),
                  ),
                  if (!showDesktopLinks) ...[
                    const Spacer(),
                    IconButton(
                      onPressed: onOpenDrawer,
                      icon: const Icon(Icons.menu_rounded),
                      color: Colors.white,
                    ),
                  ] else ...[
                    const Spacer(),
                    _NavLink(label: 'Home', onTap: onHomeTap),
                    _NavLink(label: 'About', onTap: onAboutTap),
                    _NavLink(label: 'Skills', onTap: onSkillsTap),
                    _NavLink(label: 'Projects', onTap: onProjectsTap),
                    _NavLink(label: 'Contact', onTap: onContactTap),
                    const SizedBox(width: 12),
                    _HireMeButton(onPressed: onHireMeTap),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.bodyMuted,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}

class _HireMeButton extends StatelessWidget {
  const _HireMeButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final t = PortfolioMotion.phaseOf(context);
    final g = 0.5 + 0.5 * math.sin(t * math.pi * 2 * 1.15);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        gradient: AppColors.primaryButtonGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonGradientStart.withValues(alpha: 0.42 + 0.16 * g),
            blurRadius: 14 + 12 * g,
            spreadRadius: 0.4 * g,
            offset: Offset(0, 6 + 5 * g),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Text(
              'Hire me',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
