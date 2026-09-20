import 'package:flutter/material.dart';

/// Drives soft, looping motion across the portfolio (phase in \[0, 1\]).
///
/// Rebuilds dependents when [phase] changes. Use [phaseOf] inside [build] so
/// widgets stay in sync with the root [ListenableBuilder].
class PortfolioMotion extends InheritedWidget {
  const PortfolioMotion({
    super.key,
    required this.phase,
    required super.child,
  });

  final double phase;

  static double phaseOf(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<PortfolioMotion>();
    return scope?.phase ?? 0;
  }

  @override
  bool updateShouldNotify(covariant PortfolioMotion oldWidget) {
    return oldWidget.phase != phase;
  }
}
