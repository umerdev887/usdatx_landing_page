import 'dart:ui';

import 'package:flutter/material.dart';

class ContactSection extends StatefulWidget {
  final bool isVisible;

  const ContactSection({super.key, this.isVisible = false});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _revealController;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeIn = CurvedAnimation(
      parent: _revealController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void didUpdateWidget(ContactSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _revealController.forward();
    }
  }

  @override
  void dispose() {
    _revealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _fadeIn,
      builder: (context, child) {
        return Opacity(opacity: _fadeIn.value, child: child);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
        ),
        child: Column(
          children: [
            // Section label
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: theme.colorScheme.primary.withAlpha(40),
                ),
                color: theme.colorScheme.primary.withAlpha(10),
              ),
              child: Text(
                'GET IN TOUCH',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'START YOUR PROJECT',
              style: theme.textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Tell us about your idea — we\'ll get back within 24 hours.',
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 64),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(36),
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor.withAlpha(180),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: theme.colorScheme.outline.withAlpha(60),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(40),
                            blurRadius: 40,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: const _ContactForm(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bottleneckController = TextEditingController();
  String? _selectedIndustry;
  bool _isSubmitHovered = false;

  final List<String> _industries = [
    'Logistics & Industrial',
    'Retail & Tech',
    'Automotive',
    'Healthcare',
    'Education',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bottleneckController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Briefing initialized. Our team will contact you shortly.',
          ),
        ),
      );
      _formKey.currentState?.reset();
      _nameController.clear();
      _emailController.clear();
      _bottleneckController.clear();
      setState(() {
        _selectedIndustry = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name field
          TextFormField(
            controller: _nameController,
            style: TextStyle(color: theme.colorScheme.onSurface),
            decoration: InputDecoration(
              labelText: 'Full Name / Business Name',
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: theme.colorScheme.primary.withAlpha(120),
                size: 20,
              ),
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'Please enter a name' : null,
          ),
          const SizedBox(height: 20),

          // Email field
          TextFormField(
            controller: _emailController,
            style: TextStyle(color: theme.colorScheme.onSurface),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email Address',
              prefixIcon: Icon(
                Icons.email_outlined,
                color: theme.colorScheme.primary.withAlpha(120),
                size: 20,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email';
              }
              if (!value.contains('@') || !value.contains('.')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Industry dropdown
          DropdownButtonFormField<String>(
            initialValue: _selectedIndustry,
            dropdownColor: theme.colorScheme.surfaceContainerHighest,
            style: TextStyle(color: theme.colorScheme.onSurface),
            decoration: InputDecoration(
              labelText: 'Industry Type',
              prefixIcon: Icon(
                Icons.business_outlined,
                color: theme.colorScheme.primary.withAlpha(120),
                size: 20,
              ),
            ),
            items: _industries.map((industry) {
              return DropdownMenuItem(value: industry, child: Text(industry));
            }).toList(),
            onChanged: (value) => setState(() => _selectedIndustry = value),
            validator: (value) =>
                value == null ? 'Please select an industry' : null,
          ),
          const SizedBox(height: 20),

          // Bottleneck field
          TextFormField(
            controller: _bottleneckController,
            style: TextStyle(color: theme.colorScheme.onSurface),
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Project Details',
              alignLabelWithHint: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Icon(
                  Icons.description_outlined,
                  color: theme.colorScheme.primary.withAlpha(120),
                  size: 20,
                ),
              ),
            ),
            validator: (value) => value == null || value.isEmpty
                ? 'Please provide some details'
                : null,
          ),
          const SizedBox(height: 32),

          // Submit button
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _isSubmitHovered = true),
            onExit: (_) => setState(() => _isSubmitHovered = false),
            child: SizedBox(
              width: double.infinity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary
                          .withAlpha(_isSubmitHovered ? 80 : 30),
                      blurRadius: _isSubmitHovered ? 25 : 10,
                      spreadRadius: _isSubmitHovered ? 1 : 0,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Get Your Free Quote',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.send_rounded,
                        size: 18,
                        color: theme.scaffoldBackgroundColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
