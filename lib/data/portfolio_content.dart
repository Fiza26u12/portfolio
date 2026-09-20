import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import 'models/experience_item.dart';
import 'models/project_item.dart';
import 'models/skill_item.dart';
import 'models/stat_item.dart';

/// Static copy and structured data matching the portfolio design.
abstract final class PortfolioContent {
  static const String name = 'Fiza Sheikh';
  static const String initialsBrand = 'FS.';
  static const String email = 'sheikhfiza300@gmail.com';
  static const String linkedinUrl =
      'https://www.linkedin.com/in/fiza-sheikh-11622224a';
  static const String phoneDisplay = '8789776383';
  static const String phoneDial = '+918789776383';
  static const String location = 'Chandigarh';

  static const String heroTaglineLead = 'Flutter Developer ';
  static const String heroTaglineHighlight =
      'crafting beautiful mobile experiences';

  static const String heroDescription =
      '2+ years building scalable, high-performance cross-platform mobile applications '
      'with Flutter, Firebase, REST APIs and clean architecture.';

  static const List<StatItem> stats = [
    StatItem(
      emoji: '⚡',
      value: '2+',
      label: 'Years of Experience',
      emojiColor: AppColors.aboutStatEmoji,
    ),
    StatItem(
      emoji: '📱',
      value: '10+',
      label: 'Apps Delivered',
      emojiColor: AppColors.aboutStatEmojiPhone,
    ),
    StatItem(
      emoji: '✨',
      value: '100%',
      label: 'Client Satisfaction',
      emojiColor: AppColors.aboutStatEmojiStars,
    ),
  ];

  static const List<SkillItem> skills = [
    SkillItem(name: 'Flutter', ringColor: Color(0xFFFF6B9D)),
    SkillItem(name: 'Dart', ringColor: Color(0xFF2DD4BF)),
    SkillItem(name: 'Firebase', ringColor: Color(0xFFFACC15)),
    SkillItem(name: 'Postman', ringColor: Color(0xFF60A5FA)),
    SkillItem(name: 'Swagger', ringColor: Color(0xFFA78BFA)),
    SkillItem(name: 'AWS', ringColor: Color(0xFFFF8D6B)),
  ];

  static const List<ExperienceItem> experience = [
    ExperienceItem(
      dateRange: 'Aug 2025 — Present',
      title: 'Flutter Developer',
      company: '@ NS Ventures',
      bullets: [
        'Shipped Holdflight CRM, Holdflight Demo (multi-agent AI showcase), and Marketing Planner—Flutter and Flutter Web experiences end to end.',
        'Owned UI architecture, API integration, and polished flows for demos, internal tools, and customer-facing releases.',
        'Collaborated closely on product direction, performance tuning, and iterative delivery from prototype to production.',
      ],
      alignLeft: true,
    ),
    ExperienceItem(
      dateRange: 'Apr 2025 — Jul 2025',
      title: 'Flutter Developer',
      company: '@ ToXSL Technologies',
      bullets: [
        'Built and deployed Flutter apps for Android & iOS with enhanced load speed and performance.',
        'Collaborated with designers and product teams to deliver production-ready applications.',
        'Integrated Firebase for real-time data and push notifications.',
      ],
      alignLeft: false,
    ),
    ExperienceItem(
      dateRange: 'Jan 2024 — Mar 2025',
      title: 'Flutter Developer',
      company: '@ Key Software Services Pvt Ltd',
      bullets: [
        'Developed scalable mobile apps using Flutter and Firebase.',
        'Built RESTful APIs using Node.js to support frontend features.',
        'Designed clean and responsive UI components with Material Design.',
        'Ensured smooth backend communication using Postman and Swagger.',
      ],
      alignLeft: true,
    ),
  ];

  static const List<ProjectItem> projects = [
    ProjectItem(
      iconEmoji: '🩺',
      title: 'Close Care',
      subtitle: 'Flutter • Firebase • iOS',
      description:
          'Saudi marketplace for home healthcare and personal care: book licensed nurses, '
          'physiotherapy, doctor visits, and more with real-time tracking and a polished mobile experience.',
      externalUrl: 'https://apps.apple.com/in/app/close-care/id6743693327',
    ),
    ProjectItem(
      iconEmoji: '🛍️',
      title: 'E-commerce App',
      subtitle: 'Flutter • REST APIs',
      description:
          'Product listings, cart and order modules with integrated payment gateways and backend communication.',
    ),
    ProjectItem(
      iconEmoji: '📊',
      title: 'Holdflight CRM',
      subtitle: 'Flutter Web • Dashboard',
      description:
          'Operations-focused CRM for teams to manage leads, accounts, and follow-ups with role-based access, '
          'pipeline views, and a responsive web UI tuned for daily workflows.',
      externalUrl: 'https://holdflight-crm-9b96b.web.app',
    ),
    ProjectItem(
      iconEmoji: '🤖',
      title: 'Holdflight Demo',
      subtitle: 'Web • Multi-agent AI',
      description:
          'Interactive demo web app showcasing multiple AI agents working together through a modern UI—'
          'orchestrated assistants, streamlined flows, and a glimpse at agent-driven automation.',
      externalUrl: 'https://holdflight-modern.web.app',
    ),
    ProjectItem(
      iconEmoji: '✨',
      title: 'Marketing Planner',
      subtitle: 'Flutter • Content workflows',
      description:
          'Marketing teams generate on-brand social posts through guided UI flows: brief the app with tone and '
          'goals, review suggestions, and ship creatives aligned with each company’s voice.',
    ),
  ];

  static const String degreeTitle = 'Bachelor of Engineering';
  static const String institutionName =
      'Gandhi Institute for Education & Technology';
  static const String institutionLocation = 'Bhubaneswar, Odisha';
  static const String educationDateRange = 'Dec 2020 — Apr 2024';

  static const String contactHeading = "Let's Build Something";
  static const String contactBody =
      "Have a Flutter project in mind? I'd love to hear about it. Drop a message and let's turn your idea into a beautiful mobile app.";
}
