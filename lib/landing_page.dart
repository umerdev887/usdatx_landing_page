import 'package:flutter/material.dart';

import 'industrial_particle_background.dart';
import 'responsive_layout.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _scrollToSection(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      endDrawer: _buildDrawer(context),
      body: Stack(
        children: [
          const Positioned.fill(child: IndustrialParticleBackground()),
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _HeroSection(
                    onRequestDiscovery: () => _scrollToSection(2000),
                  ),
                  _buildCapabilitiesSection(context),
                  _buildCoreEngineSection(context),
                  _buildContactSection(context),
                  _buildFooterSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1E1E1E),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF121212)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.hub, color: Color(0xFF00E5FF), size: 48),
                const SizedBox(height: 16),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                    children: [
                      TextSpan(
                        text: 'USTAD',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: 'X',
                        style: TextStyle(color: Color(0xFF00E5FF)),
                      ),
                      TextSpan(
                        text: ' SYSTEMS',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.cloud_done, color: Color(0xFF00E5FF)),
            title: const Text(
              'Services',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(800);
            },
          ),
          ListTile(
            leading: const Icon(Icons.architecture, color: Color(0xFF00E5FF)),
            title: const Text(
              'Architecture',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(1600);
            },
          ),
          ListTile(
            leading: const Icon(Icons.mail, color: Color(0xFF00E5FF)),
            title: const Text('Contact', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(2000);
            },
          ),
        ],
      ),
    );
  }

  // App Bar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    bool isMobile = ResponsiveLayout.isMobile(context);
    return AppBar(
      backgroundColor: const Color(0xFF1E1E1E).withOpacity(0.95),
      elevation: 0,
      title: Row(
        children: [
          const Icon(Icons.bolt_outlined, color: Color(0xFF00E5FF), size: 32),
          const SizedBox(width: 8),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
              children: [
                TextSpan(
                  text: 'USTAD',
                  style: TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: 'X',
                  style: TextStyle(color: Color(0xFF00E5FF)),
                ),
                TextSpan(
                  text: ' SYSTEMS',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: isMobile
          ? [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
              ),
            ]
          : [
              _NavBarItem(
                title: 'Services',
                onTap: () => _scrollToSection(800),
              ),
              _NavBarItem(
                title: 'Architecture',
                onTap: () => _scrollToSection(1600),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => _scrollToSection(2000),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E5FF),
                  foregroundColor: const Color(0xFF121212),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  'Contact',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 24),
            ],
    );
  }

  Widget _buildCapabilitiesSection(BuildContext context) {
    bool isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: const Color(0xFF1E1E1E),
      child: Column(
        children: [
          Text(
            'SYSTEM CAPABILITIES',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: const Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(width: 80, height: 2, color: const Color(0xFF00E5FF)),
          const SizedBox(height: 64),
          LayoutBuilder(
            builder: (context, constraints) {
              double cardWidth = isMobile
                  ? constraints.maxWidth
                  : (constraints.maxWidth - 48) / 3;
              if (!isMobile && cardWidth > 400) cardWidth = 400; // max width

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [
                  SizedBox(
                    width: cardWidth,
                    child: const _CapabilityCard(
                      icon: Icons.precision_manufacturing_outlined,
                      title: 'Industrial ERP & Logistics',
                      subtext:
                          'Real-time weighbridge integrations, yard asset logging, and multi-tier supply chain tracking logs designed for massive industrial compliance.',
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: const _CapabilityCard(
                      icon: Icons.inventory_2_outlined,
                      title: 'Smart Inventory & Showrooms',
                      subtext:
                          'High-performance digital catalogs, live stock intake via mobile device camera integrations, and background profit-margin telemetry dashboards.',
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: const _CapabilityCard(
                      icon: Icons.account_tree_outlined,
                      title: 'Workflow Automation',
                      subtext:
                          'Multi-step operational stage tracking, automatic WhatsApp/SMS dispatch alerts, and secure executive command dashboards.',
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

  Widget _buildCoreEngineSection(BuildContext context) {
    bool isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: const Color(0xFF121212),
      child: Column(
        children: [
          Text(
            'CORE ENGINE',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: const Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(width: 80, height: 2, color: const Color(0xFF00E5FF)),
          const SizedBox(height: 24),
          Text(
            'One Codebase. Absolute Coverage. Built entirely on Flutter Web & Mobile frameworks for synchronized execution.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: const Color(0xFF9E9E9E),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 64),
          ResponsiveLayout(
            mobile: Column(children: _coreEngineMockups(isMobile: true)),
            tablet: Column(children: _coreEngineMockups(isMobile: true)),
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: _coreEngineMockups(isMobile: false)[0]),
                _coreEngineMockups(isMobile: false)[1],
                Flexible(
                  flex: 2,
                  child: _coreEngineMockups(isMobile: false)[2],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _coreEngineMockups({required bool isMobile}) {
    return [
      Container(
        width: 250,
        height: 500,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: const Color(0xFF2C2C2C), width: 4),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00E5FF).withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(-10, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Expanded(
              child: Center(
                child: Icon(
                  Icons.phone_android,
                  size: 64,
                  color: Color(0xFF00E5FF),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: isMobile ? 48 : 0, width: isMobile ? 0 : 64),
      Container(
        width: isMobile ? double.infinity : 600,
        height: isMobile ? 300 : 400,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF2C2C2C), width: 4),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00E5FF).withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(10, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Color(0xFF2C2C2C),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.orangeAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Center(
                child: Icon(
                  Icons.desktop_windows,
                  size: 80,
                  color: Color(0xFF00E5FF),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildContactSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: const Color(0xFF1E1E1E),
      child: Column(
        children: [
          Text(
            'ENTERPRISE ENGAGEMENT PORTAL',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: const Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(width: 80, height: 2, color: const Color(0xFF00E5FF)),
          const SizedBox(height: 16),
          Text(
            'Secure your system discovery briefing today.',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: const Color(0xFF9E9E9E)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 64),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: const Color(0xFF121212),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF2C2C2C)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const _ContactForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      color: const Color(0xFF1E1E1E),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.hub, color: Color(0xFF00E5FF), size: 24),
              const SizedBox(width: 8),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  children: [
                    TextSpan(
                      text: 'USTAD',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: 'X',
                      style: TextStyle(color: Color(0xFF00E5FF)),
                    ),
                    TextSpan(
                      text: ' SYSTEMS',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            '© 2026 UstadX Systems. All rights reserved.',
            style: TextStyle(color: Color(0xFF9E9E9E)),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBarItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _CapabilityCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtext;

  const _CapabilityCard({
    required this.icon,
    required this.title,
    required this.subtext,
  });

  @override
  State<_CapabilityCard> createState() => _CapabilityCardState();
}

class _CapabilityCardState extends State<_CapabilityCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 1.0, end: _isHovered ? 1.03 : 1.0),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        builder: (context, scale, child) {
          return Transform.scale(scale: scale, child: child);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFF00E5FF)
                  : const Color(0xFF2C2C2C),
              width: 1.5,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: const Color(0xFF00E5FF).withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              else
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(widget.icon, size: 48, color: const Color(0xFF00E5FF)),
                    const SizedBox(height: 24),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 150,
                      child: Text(
                        widget.subtext,
                        style: const TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Telemetry vector bars
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 4,
                              height: 16,
                              color: const Color(0xFF00E5FF).withOpacity(0.3),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 4,
                              height: 28,
                              color: const Color(0xFF00E5FF).withOpacity(0.6),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 4,
                              height: 12,
                              color: const Color(0xFF00E5FF).withOpacity(0.2),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 4,
                              height: 36,
                              color: const Color(0xFF00E5FF),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 4,
                              height: 20,
                              color: const Color(0xFF00E5FF).withOpacity(0.4),
                            ),
                          ],
                        ),
                        // Large vector watermark
                        Icon(
                          widget.icon,
                          size: 72,
                          color: const Color(0xFF2C2C2C),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// class _NetworkGridPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = const Color(0xFF00E5FF).withOpacity(0.15)
//       ..strokeWidth = 1.0
//       ..style = PaintingStyle.stroke;

//     final nodePaint = Paint()
//       ..color = const Color(0xFF00E5FF)
//       ..style = PaintingStyle.fill;

//     // Draw grid lines
//     const int lines = 10;
//     for (int i = 0; i <= lines; i++) {
//       double dx = size.width * (i / lines);
//       canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);

//       double dy = size.height * (i / lines);
//       canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
//     }

//     // Draw nodes at intersections randomly
//     final nodes = [
//       Offset(size.width * 0.2, size.height * 0.2),
//       Offset(size.width * 0.8, size.height * 0.3),
//       Offset(size.width * 0.5, size.height * 0.5),
//       Offset(size.width * 0.3, size.height * 0.8),
//       Offset(size.width * 0.7, size.height * 0.7),
//       Offset(size.width * 0.9, size.height * 0.6),
//       Offset(size.width * 0.1, size.height * 0.6),
//     ];

//     for (var node in nodes) {
//       canvas.drawCircle(node, 4.0, nodePaint);
//       canvas.drawCircle(
//         node,
//         10.0,
//         paint
//           ..strokeWidth = 1.5
//           ..color = const Color(0xFF00E5FF).withOpacity(0.5),
//       );
//     }

//     // Draw connecting lines between nodes
//     paint.color = const Color(0xFF00E5FF).withOpacity(0.3);
//     paint.strokeWidth = 2.0;
//     canvas.drawLine(nodes[0], nodes[2], paint);
//     canvas.drawLine(nodes[1], nodes[2], paint);
//     canvas.drawLine(nodes[2], nodes[3], paint);
//     canvas.drawLine(nodes[2], nodes[4], paint);
//     canvas.drawLine(nodes[0], nodes[6], paint);
//     canvas.drawLine(nodes[1], nodes[5], paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bottleneckController = TextEditingController();
  String? _selectedIndustry;

  final List<String> _industries = [
    'Logistics & Industrial',
    'Retail & Tech',
    'Automotive',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _bottleneckController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Basic validation passed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Briefing initialized. Our team will contact you shortly.',
          ),
          backgroundColor: Color(0xFF00E5FF),
          behavior: SnackBarBehavior.floating,
        ),
      );
      _formKey.currentState?.reset();
      _nameController.clear();
      _bottleneckController.clear();
      setState(() {
        _selectedIndustry = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF2C2C2C)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF00E5FF), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            style: const TextStyle(color: Colors.white),
            decoration: inputDecoration.copyWith(
              labelText: 'Full Name / Business Name',
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'Please enter a name' : null,
          ),
          const SizedBox(height: 24),
          DropdownButtonFormField<String>(
            value: _selectedIndustry,
            dropdownColor: const Color(0xFF1E1E1E),
            style: const TextStyle(color: Colors.white),
            decoration: inputDecoration.copyWith(labelText: 'Industry Type'),
            items: _industries.map((industry) {
              return DropdownMenuItem(value: industry, child: Text(industry));
            }).toList(),
            onChanged: (value) => setState(() => _selectedIndustry = value),
            validator: (value) =>
                value == null ? 'Please select an industry' : null,
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _bottleneckController,
            style: const TextStyle(color: Colors.white),
            maxLines: 4,
            decoration: inputDecoration.copyWith(
              labelText: 'Primary Operational Bottleneck',
              alignLabelWithHint: true,
            ),
            validator: (value) => value == null || value.isEmpty
                ? 'Please describe your bottleneck'
                : null,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E5FF),
                foregroundColor: const Color(0xFF121212),
                padding: const EdgeInsets.symmetric(vertical: 20),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Initialize Briefing'),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatefulWidget {
  final VoidCallback onRequestDiscovery;

  const _HeroSection({required this.onRequestDiscovery});

  @override
  State<_HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<_HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _headlineOpacity;
  late Animation<Offset> _headlineSlide;
  late Animation<double> _subheadOpacity;
  bool _isHovered = false;
  bool _hasMouse = false;
  Offset _mousePosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _headlineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1200 / 1500, curve: Curves.easeOutCubic),
      ),
    );

    _headlineSlide = Tween<Offset>(begin: const Offset(0, 30), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 1200 / 1500, curve: Curves.easeOutCubic),
          ),
        );

    _subheadOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          300 / 1500,
          1500 / 1500,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveLayout.isMobile(context);
    final size = MediaQuery.of(context).size;
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final currentMouseX = _hasMouse ? _mousePosition.dx : centerX;
    final currentMouseY = _hasMouse ? _mousePosition.dy : centerY;

    final parallaxX = ((currentMouseX - centerX) / centerX).clamp(-1.0, 1.0);
    final parallaxY = ((currentMouseY - centerY) / centerY).clamp(-1.0, 1.0);

    Widget leftColumn = Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: _headlineSlide.value,
              child: Opacity(opacity: _headlineOpacity.value, child: child),
            );
          },
          child: Text(
            'ENGINEERING HIGH-PERFORMANCE\nOPERATIONAL SYSTEMS',
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFFFFFFF),
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 24),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(opacity: _subheadOpacity.value, child: child);
          },
          child: Text(
            'UstadX Systems deploys custom, cross-platform enterprise software and mobile ecosystems that eliminate operational leakage, automate workflows, and scale your business infrastructure.',
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF9E9E9E),
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 40),
        GestureDetector(
          onTap: widget.onRequestDiscovery,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: _isHovered ? Colors.transparent : const Color(0xFF00E5FF),
              border: Border.all(color: const Color(0xFF00E5FF), width: 2),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: const Color(0xFF00E5FF).withOpacity(0.6),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _isHovered
                    ? const Color(0xFF00E5FF)
                    : const Color(0xFF121212),
              ),
              child: const Text('Request System Discovery'),
            ),
          ),
        ),
      ],
    );

    Widget rightColumn = TweenAnimationBuilder<Offset>(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      tween: Tween<Offset>(
        begin: Offset.zero,
        end: Offset(parallaxX, parallaxY),
      ),
      builder: (context, offset, child) {
        return Transform.translate(
          offset: Offset(-offset.dx * 20, -offset.dy * 20),
          child: child,
        );
      },
      // child: SizedBox(
      //   height: 400,
      //   width: isMobile ? double.infinity : 500,
      //   child: CustomPaint(painter: _NetworkGridPainter()),
      // ),
    );

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: TweenAnimationBuilder<Offset>(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        tween: Tween<Offset>(
          begin: Offset.zero,
          end: Offset(parallaxX, parallaxY),
        ),
        builder: (context, offset, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(-offset.dy * 0.03)
              ..rotateY(offset.dx * 0.03),
            alignment: FractionalOffset.center,
            child: child,
          );
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 48.0,
            ),
            child: ResponsiveLayout(
              mobile: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [leftColumn, const SizedBox(height: 48), rightColumn],
              ),
              tablet: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [leftColumn, const SizedBox(height: 48), rightColumn],
              ),
              desktop: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 3, child: leftColumn),
                  // const SizedBox(width: 48),
                  // Expanded(flex: 2, child: rightColumn),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
