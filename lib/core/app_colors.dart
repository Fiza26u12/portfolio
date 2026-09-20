import 'package:flutter/material.dart';

/// Locked palette from reference (second screenshot): `#0F051D` base, lavender `#D1A3FF`,
/// primary buttons `linear-gradient(#B372FF → #8000FF)`, panels `#2D2D3A`.
abstract final class AppColors {
  static const Color scaffold = Color(0xFF0F051D);
  static const Color backgroundDeep = Color(0xFF06030D);
  static const Color radialGlow = Color(0xFF241538);
  static const Color radialMid = Color(0xFF140A22);

  static const Color accentLavender = Color(0xFFD1A3FF);

  static const Color buttonGradientStart = Color(0xFFB372FF);
  static const Color buttonGradientEnd = Color(0xFF8000FF);

  static const LinearGradient primaryButtonGradient = LinearGradient(
    colors: [buttonGradientStart, buttonGradientEnd],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Color bodyText = Color(0xFFE8E6ED);
  static const Color bodyMuted = Color(0xFFB8B4C9);

  static const Color navLogo = Color(0xFFFFFFFF);
  static const Color iconLocation = Color(0xFFFF6B6B);
  static const Color iconEmail = Color(0xFFFFFFFF);
  static const Color iconPhone = Color(0xFF34D399);

  /// Header glass: dark violet (no white tint).
  static const Color glassFill = Color(0xE60F051D);

  static const Color cardBorder = Color(0x59B372FF);
  static const Color progressTrack = Color(0xFF1A1524);

  /// About stat + bio: near-black purple glass (`#0B0118`) + light edge accent.
  static const Color aboutCardSurface = Color(0xFF0B0118);
  /// Top / left “white accent” rim (faint lavender-white).
  static const Color aboutCardEdgeLight = Color(0x55F5F0FF);
  static const Color aboutCardGlowAccent = Color(0x40EDE9FE);
  static const Color aboutBioHighlight = Color(0xFFD18BFF);
  static const Color aboutSectionTitle = Color(0xFFF8F5FF);
  static const Color aboutStatEmoji = Color(0xFFFCD34D);
  static const Color aboutStatEmojiPhone = Color(0xFF4ADE80);
  static const Color aboutStatEmojiStars = Color(0xFFFBBF24);

  /// Panel depth: subtle violet lift at the top-left fading to the base surface.
  static const Color panelSurfaceTop = Color(0xFF190B2D);
  static const Color panelSurfaceBottom = Color(0xFF0A0116);

  /// Brand colour for the LinkedIn badge.
  static const Color linkedIn = Color(0xFF0A66C2);

  /// M3 / seed fallbacks
  static const Color accentViolet = buttonGradientEnd;
}
