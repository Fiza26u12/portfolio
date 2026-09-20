import 'package:flutter/material.dart';

class StatItem {
  const StatItem({
    required this.emoji,
    required this.value,
    required this.label,
    this.emojiColor,
  });

  final String emoji;
  final String value;
  final String label;
  final Color? emojiColor;
}
