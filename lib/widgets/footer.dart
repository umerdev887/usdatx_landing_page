import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responsive_layout.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback onServicesTap;
  final VoidCallback onArchitectureTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const FooterSection({
    super.key,
    required this.onServicesTap,
    required this.onArchitectureTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            width: 1,
            color: theme.colorScheme.outline.withAlpha(30),
          ),
        ),
      ),
      child: Column(
        children: [
          // Gradient top accent line
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  theme.colorScheme.primary.withAlpha(80),
                  theme.colorScheme.secondary.withAlpha(60),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 56,
              horizontal: isMobile ? 24 : 48,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: isMobile
                  ? _buildMobileFooter(theme)
                  : _buildDesktopFooter(theme),
            ),
          ),
          // Bottom copyright bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withAlpha(80),
              border: Border(
                top: BorderSide(color: theme.colorScheme.outline.withAlpha(20)),
              ),
            ),
            child: Center(
              child: Text(
                '© 2026 UstadX Systems. All rights reserved.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant.withAlpha(120),
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopFooter(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand column
        Expanded(flex: 2, child: _buildBrandColumn(theme)),
        const SizedBox(width: 48),
        // Quick links
        Expanded(child: _buildQuickLinksColumn(theme)),
        const SizedBox(width: 48),
        // Connect
        Expanded(child: _buildConnectColumn(theme)),
      ],
    );
  }

  Widget _buildMobileFooter(ThemeData theme) {
    return Column(
      children: [
        _buildBrandColumn(theme),
        const SizedBox(height: 40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildQuickLinksColumn(theme)),
            Expanded(child: _buildConnectColumn(theme)),
          ],
        ),
      ],
    );
  }

  Widget _buildBrandColumn(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: theme.colorScheme.primary.withAlpha(60),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.bolt_rounded,
                color: theme.colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 20,
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
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Engineering high-performance operational systems for industries that refuse to compromise.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 24),
        // Social icons
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSocialIcon(
              theme,
              FontAwesomeIcons.linkedin,
              'https://linkedin.com',
            ),
            const SizedBox(width: 12),
            _buildSocialIcon(
              theme,
              FontAwesomeIcons.github,
              'https://github.com',
            ),
            const SizedBox(width: 12),
            _buildSocialIcon(
              theme,
              FontAwesomeIcons.envelope,
              'mailto:hello@ustadx.com',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickLinksColumn(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUICK LINKS',
          style: theme.textTheme.labelMedium?.copyWith(
            fontSize: 12,
            letterSpacing: 2,
            color: theme.colorScheme.onSurface.withAlpha(100),
          ),
        ),
        const SizedBox(height: 20),
        _buildFooterLink(theme, 'Services', onServicesTap),
        _buildFooterLink(theme, 'Architecture', onArchitectureTap),
        _buildFooterLink(theme, 'Projects', onProjectsTap),
        _buildFooterLink(theme, 'Contact', onContactTap),
      ],
    );
  }

  Widget _buildConnectColumn(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CONNECT',
          style: theme.textTheme.labelMedium?.copyWith(
            fontSize: 12,
            letterSpacing: 2,
            color: theme.colorScheme.onSurface.withAlpha(100),
          ),
        ),
        const SizedBox(height: 20),
        _buildInfoRow(theme, Icons.email_outlined, 'hello@ustadx.com'),
        const SizedBox(height: 12),
        _buildInfoRow(theme, Icons.location_on_outlined, 'India'),
      ],
    );
  }

  Widget _buildFooterLink(ThemeData theme, String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(ThemeData theme, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.primary.withAlpha(120)),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(ThemeData theme, IconData icon, String url) {
    return _SocialIconButton(theme: theme, icon: icon, url: url);
  }
}

class _SocialIconButton extends StatefulWidget {
  final ThemeData theme;
  final IconData icon;
  final String url;

  const _SocialIconButton({
    required this.theme,
    required this.icon,
    required this.url,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered
                  ? widget.theme.colorScheme.primary.withAlpha(120)
                  : widget.theme.colorScheme.outline.withAlpha(50),
            ),
            color: _isHovered
                ? widget.theme.colorScheme.primary.withAlpha(15)
                : Colors.transparent,
          ),
          child: FaIcon(
            widget.icon,
            size: 18,
            color: _isHovered
                ? widget.theme.colorScheme.primary
                : widget.theme.colorScheme.onSurfaceVariant.withAlpha(150),
          ),
        ),
      ),
    );
  }
}
