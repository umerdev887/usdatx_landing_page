import 'package:flutter/material.dart';

import 'industrial_particle_background.dart';
import 'responsive_layout.dart';
import 'widgets/glass_app_bar.dart';
import 'widgets/hero_section.dart';
import 'widgets/capability_card.dart';
import 'widgets/section_divider.dart';
import 'widgets/why_choose_us_section.dart';
import 'widgets/process_section.dart';
import 'widgets/core_engine_section.dart';
import 'widgets/projects_section.dart';
import 'widgets/testimonials_section.dart';
import 'widgets/stats_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/footer.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Section keys for scroll targeting
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _whyChooseUsKey = GlobalKey();
  final GlobalKey _processKey = GlobalKey();
  final GlobalKey _architectureKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _testimonialsKey = GlobalKey();
  final GlobalKey _statsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // Scroll-triggered visibility flags
  bool _capabilitiesVisible = false;
  bool _whyChooseUsVisible = false;
  bool _processVisible = false;
  bool _coreEngineVisible = false;
  bool _projectsVisible = false;
  bool _testimonialsVisible = false;
  bool _statsVisible = false;
  bool _contactVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Trigger initial check after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _onScroll());
  }

  void _onScroll() {
    _checkVisibility(_servicesKey, () {
      if (!_capabilitiesVisible) setState(() => _capabilitiesVisible = true);
    });
    _checkVisibility(_whyChooseUsKey, () {
      if (!_whyChooseUsVisible) setState(() => _whyChooseUsVisible = true);
    });
    _checkVisibility(_processKey, () {
      if (!_processVisible) setState(() => _processVisible = true);
    });
    _checkVisibility(_architectureKey, () {
      if (!_coreEngineVisible) setState(() => _coreEngineVisible = true);
    });
    _checkVisibility(_projectsKey, () {
      if (!_projectsVisible) setState(() => _projectsVisible = true);
    });
    _checkVisibility(_testimonialsKey, () {
      if (!_testimonialsVisible) setState(() => _testimonialsVisible = true);
    });
    _checkVisibility(_statsKey, () {
      if (!_statsVisible) setState(() => _statsVisible = true);
    });
    _checkVisibility(_contactKey, () {
      if (!_contactVisible) setState(() => _contactVisible = true);
    });
  }

  void _checkVisibility(GlobalKey key, VoidCallback onVisible) {
    final context = key.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    final position = box.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(this.context).size.height;

    // Trigger when the top of the section enters the bottom 80% of the viewport
    if (position.dy < screenHeight * 0.85) {
      onVisible();
    }
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        onServicesTap: () => _scrollToSection(_servicesKey),
        onArchitectureTap: () => _scrollToSection(_architectureKey),
        onProjectsTap: () => _scrollToSection(_projectsKey),
        onContactTap: () => _scrollToSection(_contactKey),
        onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      endDrawer: _buildDrawer(context),
      body: Stack(
        children: [
          const Positioned.fill(child: IndustrialParticleBackground()),
          ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  HeroSection(
                    onRequestDiscovery: () => _scrollToSection(_contactKey),
                  ),
                  const SectionDivider(),
                  _buildCapabilitiesSection(context),
                  const SectionDivider(),
                  WhyChooseUsSection(
                    key: _whyChooseUsKey,
                    isVisible: _whyChooseUsVisible,
                  ),
                  const SectionDivider(),
                  ProcessSection(
                    key: _processKey,
                    isVisible: _processVisible,
                  ),
                  const SectionDivider(),
                  CoreEngineSection(
                    key: _architectureKey,
                    isVisible: _coreEngineVisible,
                  ),
                  const SectionDivider(),
                  ProjectsSection(
                    key: _projectsKey,
                    isVisible: _projectsVisible,
                  ),
                  const SectionDivider(),
                  TestimonialsSection(
                    key: _testimonialsKey,
                    isVisible: _testimonialsVisible,
                  ),
                  const SectionDivider(),
                  StatsSection(
                    key: _statsKey,
                    isVisible: _statsVisible,
                  ),
                  const SectionDivider(),
                  ContactSection(
                    key: _contactKey,
                    isVisible: _contactVisible,
                  ),
                  FooterSection(
                    onServicesTap: () => _scrollToSection(_servicesKey),
                    onArchitectureTap: () => _scrollToSection(_architectureKey),
                    onProjectsTap: () => _scrollToSection(_projectsKey),
                    onContactTap: () => _scrollToSection(_contactKey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.outline.withAlpha(30),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.colorScheme.primary.withAlpha(60),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Icons.bolt_rounded,
                    color: theme.colorScheme.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 16),
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: 'USTAD',
                        style: TextStyle(color: theme.colorScheme.onSurface),
                      ),
                      TextSpan(
                        text: 'X',
                        style: TextStyle(color: theme.colorScheme.primary),
                      ),
                      TextSpan(
                        text: ' SYSTEMS',
                        style: TextStyle(
                          color: theme.colorScheme.onSurface.withAlpha(150),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            Icons.cloud_done_rounded,
            'Services',
            () {
              Navigator.pop(context);
              _scrollToSection(_servicesKey);
            },
          ),
          _buildDrawerItem(
            context,
            Icons.architecture_rounded,
            'Architecture',
            () {
              Navigator.pop(context);
              _scrollToSection(_architectureKey);
            },
          ),
          _buildDrawerItem(
            context,
            Icons.work_outline_rounded,
            'Projects',
            () {
              Navigator.pop(context);
              _scrollToSection(_projectsKey);
            },
          ),
          _buildDrawerItem(
            context,
            Icons.analytics_outlined,
            'Stats',
            () {
              Navigator.pop(context);
              _scrollToSection(_statsKey);
            },
          ),
          _buildDrawerItem(
            context,
            Icons.mail_rounded,
            'Contact',
            () {
              Navigator.pop(context);
              _scrollToSection(_contactKey);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary, size: 22),
      title: Text(
        title,
        style: TextStyle(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
    );
  }

  Widget _buildCapabilitiesSection(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayout.isMobile(context);
    final isLight = theme.brightness == Brightness.light;

    return Container(
      key: _servicesKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isMobile ? 24 : 48,
      ),
      decoration: BoxDecoration(
        color: isLight ? Colors.white : theme.colorScheme.surface,
      ),
      child: Column(
        children: [
          // Section label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: theme.colorScheme.primary.withAlpha(isLight ? 70 : 40),
              ),
              color: theme.colorScheme.primary.withAlpha(isLight ? 15 : 10),
            ),
            child: Text(
              'SERVICES',
              style: theme.textTheme.labelMedium?.copyWith(
                fontSize: 12,
                letterSpacing: 2,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'SYSTEM CAPABILITIES',
            style: theme.textTheme.headlineLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Text(
              'Enterprise-grade solutions engineered for scale and reliability.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 64),
          LayoutBuilder(
            builder: (context, constraints) {
              double cardWidth = isMobile
                  ? constraints.maxWidth
                  : (constraints.maxWidth - 24) / 2;
              if (!isMobile && cardWidth > 500) cardWidth = 500;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [
                  SizedBox(
                    width: cardWidth,
                    child: CapabilityCard(
                      icon: Icons.precision_manufacturing_outlined,
                      title: 'ERP & Operations',
                      subtext:
                          'Real-time weighbridge integrations, yard asset logging, and multi-tier supply chain tracking designed for massive industrial compliance.',
                      index: '01',
                      isVisible: _capabilitiesVisible,
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: CapabilityCard(
                      icon: Icons.inventory_2_outlined,
                      title: 'Smart Inventory & Showrooms',
                      subtext:
                          'High-performance digital catalogs, live stock intake via mobile camera integrations, and background profit-margin telemetry dashboards.',
                      index: '02',
                      isVisible: _capabilitiesVisible,
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: CapabilityCard(
                      icon: Icons.account_tree_outlined,
                      title: 'Workflow Automation',
                      subtext:
                          'Multi-step operational stage tracking, automatic WhatsApp/SMS dispatch alerts, and secure executive command dashboards.',
                      index: '03',
                      isVisible: _capabilitiesVisible,
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: CapabilityCard(
                      icon: Icons.devices_rounded,
                      title: 'Custom Web & Mobile Apps',
                      subtext:
                          'Client-facing applications and portals built natively for iOS, Android, and Web with pixel-perfect designs and scalable backend architecture.',
                      index: '04',
                      isVisible: _capabilitiesVisible,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}