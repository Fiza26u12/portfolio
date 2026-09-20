import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData buildAppTheme() {
  const onSurface = AppColors.accentLavender;

  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.buttonGradientEnd,
    brightness: Brightness.dark,
    primary: AppColors.buttonGradientStart,
    onPrimary: Colors.white,
    secondary: AppColors.accentLavender,
    onSecondary: AppColors.backgroundDeep,
    surface: AppColors.scaffold,
    onSurface: onSurface,
    surfaceContainerLowest: Color(0xFF04020A),
    surfaceContainerLow: AppColors.backgroundDeep,
    surfaceContainer: AppColors.radialMid,
    surfaceContainerHigh: Color(0xFF1E1830),
    surfaceContainerHighest: AppColors.aboutCardSurface,
  );

  final base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.scaffold,
    canvasColor: AppColors.scaffold,
    colorScheme: scheme,
  );

  /// Noto Sans as fallback so emoji / symbols in copy render on web (Inter
  /// alone triggers “missing Noto characters” for stat/project emojis).
  final notoFamily = GoogleFonts.notoSans().fontFamily;
  final textTheme = GoogleFonts.interTextTheme(base.textTheme).apply(
    bodyColor: AppColors.bodyText,
    displayColor: Colors.white,
    fontFamilyFallback: notoFamily != null ? <String>[notoFamily] : null,
  );

  return base.copyWith(
    textTheme: textTheme,
    dividerColor: AppColors.cardBorder.withValues(alpha: 0.35),
    cardTheme: CardThemeData(
      color: AppColors.aboutCardSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.scaffold,
      surfaceTintColor: Colors.transparent,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(
        AppColors.buttonGradientStart.withValues(alpha: 0.45),
      ),
      trackColor: WidgetStateProperty.all(AppColors.scaffold.withValues(alpha: 0.35)),
      thickness: WidgetStateProperty.all(6),
    ),
    iconTheme: const IconThemeData(color: AppColors.bodyText),
  );
}
