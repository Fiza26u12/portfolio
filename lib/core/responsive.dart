import 'package:flutter/material.dart';

/// Breakpoints for [LayoutBuilder] / [MediaQuery] driven layouts.
abstract final class AppBreakpoints {
  static const double mobile = 720;
  static const double tablet = 1024;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  bool get isMobile => screenWidth < AppBreakpoints.mobile;
  bool get isTablet =>
      screenWidth >= AppBreakpoints.mobile && screenWidth < AppBreakpoints.tablet;
  bool get isDesktop => screenWidth >= AppBreakpoints.tablet;
}

double horizontalPadding(BuildContext context) {
  if (context.isMobile) return 20;
  if (context.isTablet) return 32;
  return 48;
}

/// Slightly tighter side inset on phone so About stat + bio cards read wider.
double aboutSectionHorizontalPadding(BuildContext context) {
  if (context.isMobile) return 12;
  return horizontalPadding(context);
}

double sectionVerticalGap(BuildContext context) {
  if (context.isMobile) return 72;
  if (context.isTablet) return 92;
  return 112;
}

/// Extra space between hero (contact row) and About / "Who I Am" (reference layout).
double heroToAboutSpacing(BuildContext context) {
  if (context.isMobile) return 88;
  if (context.isTablet) return 108;
  return 128;
}

double heroBottomPadding(BuildContext context) {
  if (context.isMobile) return 36;
  if (context.isTablet) return 44;
  return 52;
}

double heroTopPadding(BuildContext context) {
  if (context.isMobile) return 20;
  if (context.isTablet) return 28;
  return 36;
}

/// Space below nav before hero (scroll column).
double heroBelowNavInset(BuildContext context) {
  if (context.isMobile) return 100;
  if (context.isTablet) return 112;
  return 124;
}

/// Vertical gap above and below the hero CTA row (View My Work / Get in Touch).
double heroCtaRowVerticalGap(BuildContext context) {
  if (context.isMobile) return 44;
  if (context.isTablet) return 52;
  return 60;
}

double aboutLabelToTitleGap(BuildContext context) {
  if (context.isMobile) return 18;
  if (context.isTablet) return 20;
  return 22;
}

double aboutTitleToStatsGap(BuildContext context) {
  if (context.isMobile) return 32;
  if (context.isTablet) return 38;
  return 44;
}

double aboutStatsToBioGap(BuildContext context) {
  if (context.isMobile) return 28;
  if (context.isTablet) return 32;
  return 36;
}

double aboutStatCardGap(BuildContext context) {
  if (context.isMobile) return 12;
  return 16;
}

/// Fixed height for [ProjectCard] so every tile aligns in the projects grid.
double projectCardHeight(BuildContext context) {
  if (context.isMobile) return 332;
  if (context.isTablet) return 318;
  return 312;
}
