import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/link_launcher.dart';
import '../../core/responsive.dart';
import '../../data/portfolio_content.dart';
import '../animation/portfolio_motion.dart';
import 'portfolio_glass_panel.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrow = context.isMobile;

    return PortfolioGlassPanel(
      borderRadius: 26,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          isNarrow ? 20 : 32,
          isNarrow ? 30 : 38,
          isNarrow ? 20 : 32,
          isNarrow ? 28 : 34,
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
            const SizedBox(height: 14),
            Text(
              PortfolioContent.contactHeading,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.accentLavender,
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 14),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(
                PortfolioContent.contactBody,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.bodyText.withValues(alpha: 0.88),
                      height: 1.6,
                    ),
              ),
            ),
            SizedBox(height: isNarrow ? 26 : 30),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 14,
              runSpacing: 14,
              children: [
                _GradientContactButton(
                  icon: Icons.mail_outline_rounded,
                  label: PortfolioContent.email,
                  onPressed: () => LinkLauncher.openScheme(
                    'mailto:${PortfolioContent.email}',
                  ),
                ),
                _OutlinedContactButton(
                  icon: Icons.smartphone_rounded,
                  label: '+91 ${PortfolioContent.phoneDisplay}',
                  onPressed: () => LinkLauncher.openScheme(
                    'tel:${PortfolioContent.phoneDial}',
                  ),
                ),
              ],
            ),
            SizedBox(height: isNarrow ? 24 : 28),
            const _SocialDivider(),
            SizedBox(height: isNarrow ? 20 : 22),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 14,
              runSpacing: 12,
              children: [
                _SocialIconButton(
                  tooltip: 'LinkedIn',
                  semanticLabel: 'Open LinkedIn profile',
                  brandColor: AppColors.linkedIn,
                  icon: const LinkedInGlyph(size: 20),
                  onPressed: () =>
                      LinkLauncher.openExternal(PortfolioContent.linkedinUrl),
                ),
                _SocialIconButton(
                  tooltip: PortfolioContent.email,
                  semanticLabel: 'Send an email',
                  brandColor: AppColors.buttonGradientStart,
                  icon: const Icon(
                    Icons.alternate_email_rounded,
                    size: 22,
                    color: Colors.white,
                  ),
                  onPressed: () => LinkLauncher.openScheme(
                    'mailto:${PortfolioContent.email}',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Thin gradient rule that separates the CTA buttons from the social icons.
class _SocialDivider extends StatelessWidget {
  const _SocialDivider();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 220),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.accentLavender.withValues(alpha: 0.0),
              AppColors.accentLavender.withValues(alpha: 0.38),
              AppColors.accentLavender.withValues(alpha: 0.0),
            ],
          ),
        ),
      ),
    );
  }
}

/// LinkedIn "in" mark drawn as text so no brand asset or extra package is needed.
class LinkedInGlyph extends StatelessWidget {
  const LinkedInGlyph({super.key, this.size = 20});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Text(
          'in',
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.82,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            height: 1,
          ),
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
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
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
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
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

/// Circular social badge: brand-tinted ring that fills in on hover.
class _SocialIconButton extends StatefulWidget {
  const _SocialIconButton({
    required this.icon,
    required this.tooltip,
    required this.semanticLabel,
    required this.brandColor,
    required this.onPressed,
  });

  final Widget icon;
  final String tooltip;
  final String semanticLabel;
  final Color brandColor;
  final VoidCallback onPressed;

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _hovered = false;

  void _setHovered(bool value) {
    if (_hovered == value) return;
    setState(() => _hovered = value);
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: Semantics(
        button: true,
        label: widget.semanticLabel,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => _setHovered(true),
          onExit: (_) => _setHovered(false),
          child: GestureDetector(
            onTap: widget.onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.brandColor.withValues(alpha: _hovered ? 0.95 : 0.16),
                border: Border.all(
                  color: widget.brandColor.withValues(alpha: _hovered ? 1.0 : 0.5),
                  width: 1.4,
                ),
                boxShadow: [
                  if (_hovered)
                    BoxShadow(
                      color: widget.brandColor.withValues(alpha: 0.42),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                ],
              ),
              child: Center(child: widget.icon),
            ),
          ),
        ),
      ),
    );
  }
}
