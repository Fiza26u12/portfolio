import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../../data/portfolio_content.dart';
import '../animation/portfolio_motion.dart';
import '../widgets/about_bio_card.dart';
import '../widgets/app_gradient_background.dart';
import '../widgets/contact_section.dart';
import '../widgets/education_card.dart';
import '../widgets/experience_timeline.dart';
import '../widgets/glass_nav_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/project_card.dart';
import '../widgets/section_header.dart';
import '../widgets/hex_skills_section.dart';
import '../widgets/stat_card.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  late final AnimationController _ambientMotion = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 14),
  );

  bool _ambientStarted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_ambientStarted) return;
    _ambientStarted = true;
    if (!MediaQuery.disableAnimationsOf(context)) {
      _ambientMotion.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _ambientMotion.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;

    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: 0.08,
    );
  }

  void _openDrawerNav(BuildContext context, VoidCallback afterClose) {
    Navigator.of(context).pop();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterClose());
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _ambientMotion,
      builder: (context, _) {
        return PortfolioMotion(
          phase: _ambientMotion.value,
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: AppColors.scaffold,
            extendBodyBehindAppBar: true,
            endDrawer: _buildMobileDrawer(context),
            body: Stack(
              fit: StackFit.expand,
              children: [
                const Positioned.fill(child: AppGradientBackground()),
                Positioned.fill(child: _buildScrollableBody(context)),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: GlassNavBar(
                    onLogoTap: () => _scrollTo(_homeKey),
                    onHomeTap: () => _scrollTo(_homeKey),
                    onAboutTap: () => _scrollTo(_aboutKey),
                    onSkillsTap: () => _scrollTo(_skillsKey),
                    onProjectsTap: () => _scrollTo(_projectsKey),
                    onContactTap: () => _scrollTo(_contactKey),
                    onHireMeTap: () => _scrollTo(_contactKey),
                    onOpenDrawer: () =>
                        _scaffoldKey.currentState?.openEndDrawer(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.scaffold,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          children: [
            const SizedBox(height: 8),
            Text(
              'Navigate',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            _DrawerTile(
              label: 'Home',
              onTap: () => _openDrawerNav(context, () => _scrollTo(_homeKey)),
            ),
            _DrawerTile(
              label: 'About',
              onTap: () => _openDrawerNav(context, () => _scrollTo(_aboutKey)),
            ),
            _DrawerTile(
              label: 'Skills',
              onTap: () => _openDrawerNav(context, () => _scrollTo(_skillsKey)),
            ),
            _DrawerTile(
              label: 'Projects',
              onTap: () =>
                  _openDrawerNav(context, () => _scrollTo(_projectsKey)),
            ),
            _DrawerTile(
              label: 'Contact',
              onTap: () =>
                  _openDrawerNav(context, () => _scrollTo(_contactKey)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableBody(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: context.isDesktop,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height:
                  MediaQuery.paddingOf(context).top +
                  heroBelowNavInset(context),
            ),
            _buildHomeSection(context),
            _buildAboutSection(context),
            _buildSkillsSection(context),
            _buildExperienceSection(context),
            _buildProjectsSection(context),
            _buildEducationSection(context),
            _buildContactSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyedSection({required GlobalKey key, required Widget child}) {
    return KeyedSubtree(key: key, child: child);
  }

  Widget _buildHomeSection(BuildContext context) {
    return _buildKeyedSection(
      key: _homeKey,
      child: HeroSection(
        onViewWork: () => _scrollTo(_projectsKey),
        onGetInTouch: () => _scrollTo(_contactKey),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return _buildKeyedSection(
      key: _aboutKey,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          aboutSectionHorizontalPadding(context),
          heroToAboutSpacing(context),
          aboutSectionHorizontalPadding(context),
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SectionHeader(
              label: 'About',
              title: 'Who I Am',
              labelToTitleGap: aboutLabelToTitleGap(context),
              labelLetterSpacing: 8,
              titleColor: AppColors.aboutSectionTitle,
            ),
            SizedBox(height: aboutTitleToStatsGap(context)),
            _buildStatsRow(context),
            SizedBox(height: aboutStatsToBioGap(context)),
            const AboutBioCard(),
            SizedBox(height: sectionVerticalGap(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    final stats = PortfolioContent.stats;

    final gap = aboutStatCardGap(context);

    if (context.isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < stats.length; i++) ...[
            if (i != 0) SizedBox(height: gap),
            StatCard(item: stats[i], motionSlot: i),
          ],
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < stats.length; i++) ...[
          if (i != 0) SizedBox(width: gap),
          Expanded(
            child: StatCard(item: stats[i], motionSlot: i),
          ),
        ],
      ],
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    return _buildKeyedSection(
      key: _skillsKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding(context)),
        child: Column(
          children: [
            const SectionHeader(label: 'Skills', title: 'Technical Stack'),
            SizedBox(height: context.isMobile ? 18 : 26),
            HexSkillsHoneycomb(skills: PortfolioContent.skills),
            SizedBox(height: sectionVerticalGap(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding(context)),
      child: Column(
        children: [
          const SectionHeader(label: 'Journey', title: 'Experience'),
          SizedBox(height: context.isMobile ? 18 : 26),
          ExperienceTimeline(items: PortfolioContent.experience),
          SizedBox(height: sectionVerticalGap(context)),
        ],
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    return _buildKeyedSection(
      key: _projectsKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding(context)),
        child: Column(
          children: [
            const SectionHeader(label: 'Work', title: 'Featured Projects'),
            SizedBox(height: context.isMobile ? 18 : 26),
            LayoutBuilder(
              builder: (context, constraints) {
                final maxW = constraints.maxWidth;
                final gap = 20.0;
                final cardH = projectCardHeight(context);

                final columns = maxW >= 1100
                    ? 3
                    : maxW >= AppBreakpoints.mobile
                    ? 2
                    : 1;

                final cardWidth = (maxW - gap * (columns - 1)) / columns;

                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (var i = 0; i < PortfolioContent.projects.length; i++)
                      SizedBox(
                        width: cardWidth,
                        height: cardH,
                        child: ProjectCard(
                          item: PortfolioContent.projects[i],
                          cardHeight: cardH,
                          motionSlot: i,
                        ),
                      ),
                  ],
                );
              },
            ),
            SizedBox(height: sectionVerticalGap(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationSection(BuildContext context) {
    return _buildKeyedSection(
      key: _educationKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding(context)),
        child: Column(
          children: [
            const SectionHeader(
              label: 'Education',
              title: 'Academic Background',
            ),
            SizedBox(height: context.isMobile ? 18 : 26),
            const EducationCard(),
            SizedBox(height: sectionVerticalGap(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return _buildKeyedSection(
      key: _contactKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding(context)),
        child: const ContactSection(),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
      onTap: onTap,
    );
  }
}
