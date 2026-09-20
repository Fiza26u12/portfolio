import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../../data/portfolio_content.dart';
import '../animation/portfolio_motion.dart';
import 'portfolio_glass_panel.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launch(Uri uri) async {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) {
      // No-op: launching can fail on some desktop/web setups without handlers.
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = context.isMobile;

    return PortfolioGlassPanel(
      borderRadius: 26,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          isNarrow ? 18 : 28,
          26,
          isNarrow ? 18 : 28,
          26,
        ),
        child: Column(
          children: [
            Text(
              'CONTACT',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.accentLavender.withValues(alpha: 0.95),
                    letterSpacing: 6,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              PortfolioContent.contactHeading,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.accentLavender,
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(
                PortfolioContent.contactBody,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.bodyText,
                      height: 1.55,
                    ),
              ),
            ),
            const SizedBox(height: 22),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 14,
              runSpacing: 14,
              children: [
                _GradientContactButton(
                  icon: Icons.mail_outline_rounded,
                  label: PortfolioContent.email,
                  onPressed: () => _launch(Uri.parse('mailto:${PortfolioContent.email}')),
                ),
                _OutlinedContactButton(
                  icon: Icons.smartphone_rounded,
                  label: '+91 ${PortfolioContent.phoneDisplay}',
                  onPressed: () => _launch(Uri.parse('tel:${PortfolioContent.phoneDial}')),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SocialCircleButton(
                  label: 'L',
                  tooltip: 'LinkedIn',
                  onPressed: () => _launch(Uri.parse(PortfolioContent.linkedinUrl)),
                ),
                const SizedBox(width: 12),
                _SocialCircleButton(
                  label: 'E',
                  tooltip: 'Email',
                  onPressed: () => _launch(Uri.parse('mailto:${PortfolioContent.email}')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GradientContactButton extends StatelessWidget {
  const _GradientContactButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final t = PortfolioMotion.phaseOf(context);
    final glow = 0.5 + 0.5 * math.sin(t * math.pi * 2);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: AppColors.primaryButtonGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonGradientStart.withValues(alpha: 0.32 + 0.22 * glow),
            blurRadius: 16 + 16 * glow,
            spreadRadius: 0.4 * glow,
            offset: Offset(0, 10 + 5 * glow),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
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

class _OutlinedContactButton extends StatelessWidget {
  const _OutlinedContactButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.aboutCardSurface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.aboutCardEdgeLight.withValues(alpha: 0.28),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
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

class _SocialCircleButton extends StatelessWidget {
  const _SocialCircleButton({
    required this.label,
    required this.onPressed,
    required this.tooltip,
  });

  final String label;
  final VoidCallback onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: AppColors.aboutCardSurface,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: SizedBox(
            width: 44,
            height: 44,
            child: Center(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
