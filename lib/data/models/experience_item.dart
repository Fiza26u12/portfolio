class ExperienceItem {
  const ExperienceItem({
    required this.dateRange,
    required this.title,
    required this.company,
    required this.bullets,
    required this.alignLeft,
  });

  final String dateRange;
  final String title;
  final String company;
  final List<String> bullets;
  /// Desktop alternating layout: `true` places the card on the left side of the timeline.
  final bool alignLeft;
}
