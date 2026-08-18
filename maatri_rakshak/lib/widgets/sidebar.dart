import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routes.dart';
import '../theme/colors.dart';

class SidebarDrawer extends StatelessWidget {
  final ValueChanged<String>? onSelect;

  const SidebarDrawer({super.key, this.onSelect});

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavigationItem(
        icon: Icons.home_rounded,
        label: 'Home',
        route: Routes.landing,
      ),
      _NavigationItem(
        icon: Icons.info_outline_rounded,
        label: 'About',
        route: Routes.landing,
      ),
      _NavigationItem(
        icon: Icons.timeline_rounded,
        label: 'Flow',
        route: Routes.dashboard,
      ),
    ];

    return Drawer(
      width: 260,
      shape: const RoundedRectangleBorder(),
      child: Container(
        color: AppColors.white,
        child: Column(
          children: [
            const SizedBox(height: 34),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.lightTeal,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.favorite_rounded,
                      color: AppColors.primaryTeal,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MaatriRakshak',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.deepNavy,
                          ),
                        ),
                        Text(
                          'Early maternal emergency support',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            ...items.map((item) => item),
            const Spacer(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(
                    Icons.language_rounded,
                    color: AppColors.primaryText,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'English | मराठी',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => onSelect?.call(Routes.dashboard),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryTeal,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Sign In'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;

  const _NavigationItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = label == 'Home';
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 4, 14, 0),
      decoration: isActive
          ? BoxDecoration(
              color: AppColors.lightTeal,
              borderRadius: BorderRadius.circular(12),
            )
          : null,
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          color: isActive ? AppColors.primaryTeal : AppColors.deepNavy,
        ),
        title: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
            color: isActive ? AppColors.primaryTeal : AppColors.deepNavy,
          ),
        ),
        onTap: () => Navigator.of(context).pushNamed(route),
      ),
    );
  }
}
