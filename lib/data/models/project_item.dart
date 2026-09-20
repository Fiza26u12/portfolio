class ProjectItem {
  const ProjectItem({
    required this.iconEmoji,
    required this.title,
    required this.subtitle,
    required this.description,
    this.externalUrl,
  });

  final String iconEmoji;
  final String title;
  final String subtitle;
  final String description;

  /// App Store, web demo, or other link opened after the tap animation.
  final String? externalUrl;
}
