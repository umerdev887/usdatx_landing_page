import 'dart:ui';

import 'package:flutter/material.dart';

import 'nav_bar_item.dart';
import '../responsive_layout.dart';
import '../theme_notifier.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onServicesTap;
  final VoidCallback onArchitectureTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;
  final VoidCallback onMenuTap;

  const GlassAppBar({
    super.key,
    required this.onServicesTap,
    required this.onArchitectureTap,
    required this.onProjectsTap,
    required this.onContactTap,
    required this.onMenuTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: preferredSize.height + MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(
            color: isLight
                ? theme.colorScheme.surface.withAlpha(230)
                : theme.colorScheme.surface.withAlpha(180),
            border: Border(
              bottom: BorderSide(
                color: isLight
                    ? theme.colorScheme.outline.withAlpha(60)
                    : theme.colorScheme.primary.withAlpha(30),
                width: 1,
              ),
            ),
            boxShadow: isLight
                ? [
                    BoxShadow(
                      color: Colors.black.withAlpha(12),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                // Logo
                _buildLogo(context),
                const Spacer(),
                // Theme Toggle
                ValueListenableBuilder<ThemeMode>(
                  valueListenable: themeNotifier,
                  builder: (context, mode, child) {
                    final isDark = mode == ThemeMode.dark || 
                        (mode == ThemeMode.system && theme.brightness == Brightness.dark);
                    return IconButton(
                      icon: Icon(
                        isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                        color: theme.colorScheme.primary,
                      ),
                      onPressed: () {
                        themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
                      },
                    );
                  },
                ),
                const SizedBox(width: 8),
                // Navigation
                if (isMobile)
                  IconButton(
                    icon: Icon(
                      Icons.menu_rounded,
                      color: theme.colorScheme.onSurface,
                      size: 28,
                    ),
                    onPressed: onMenuTap,
                  )
                else
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NavBarItem(title: 'Services', onTap: onServicesTap),
                      const SizedBox(width: 8),
                      NavBarItem(
                        title: 'Architecture',
                        onTap: onArchitectureTap,
                      ),
                      const SizedBox(width: 8),
                      NavBarItem(
                        title: 'Projects',
                        onTap: onProjectsTap,
                      ),
                      const SizedBox(width: 24),
                      _buildContactButton(context),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
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
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        Text.rich(
          TextSpan(
            style: theme.textTheme.titleLarge?.copyWith(
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
    );
  }

  Widget _buildContactButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ElevatedButton(
        onPressed: onContactTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text('Contact'),
      ),
    );
  }
}
