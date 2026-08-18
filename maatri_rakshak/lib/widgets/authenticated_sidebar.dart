import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/auth/auth_service.dart';
import '../routes.dart';
import '../theme/colors.dart';

class AuthenticatedSidebar extends StatelessWidget {
  final String currentRoute;
  final bool isDrawer;

  const AuthenticatedSidebar({
    super.key,
    required this.currentRoute,
    this.isDrawer = false,
  });

  List<_NavItemData> get _items => [
    _NavItemData(Icons.dashboard_rounded, 'Dashboard', Routes.dashboard),
    _NavItemData(Icons.group_rounded, 'Patients', Routes.patients),
    _NavItemData(Icons.assignment_rounded, 'Assessments', Routes.assessments),
    _NavItemData(Icons.local_hospital_rounded, 'Facilities', Routes.facilities),
    _NavItemData(Icons.airport_shuttle_rounded, 'Transport', Routes.transport),
    _NavItemData(Icons.bar_chart_rounded, 'Reports', Routes.reports),
    _NavItemData(Icons.timeline_rounded, 'Timeline', Routes.timeline),
    _NavItemData(Icons.settings_rounded, 'Settings', Routes.settings),
    _NavItemData(Icons.language_rounded, 'Language', Routes.language),
    _NavItemData(Icons.help_outline_rounded, 'Help', Routes.help),
    _NavItemData(Icons.person_rounded, 'Profile', Routes.profile),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),
              child: _buildBrandMark(),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                children: [
                  ..._items.map(
                    (item) => _buildNavItem(
                      context,
                      item.icon,
                      item.label,
                      item.route,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildProfileFooter(context),
                  const SizedBox(height: 8),
                  _buildLogoutTile(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandMark() {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.lightTeal,
            borderRadius: BorderRadius.circular(14),
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
                  fontSize: 10,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    String route,
  ) {
    final isActive = route == currentRoute;
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
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
        onTap: () {
          if (isDrawer) {
            Navigator.of(context).pop();
          }
          Navigator.of(context).pushNamed(route);
        },
      ),
    );
  }

  Widget _buildProfileFooter(BuildContext context) {
    final isActive = currentRoute == Routes.profile;
    return Container(
      decoration: isActive
          ? BoxDecoration(
              color: AppColors.lightTeal,
              borderRadius: BorderRadius.circular(12),
            )
          : null,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.primaryTeal,
          child: const Icon(Icons.person_rounded, color: AppColors.white),
        ),
        title: Text(
          'Sunita Patil',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.deepNavy,
          ),
        ),
        subtitle: Text(
          'ASHA Worker ID: ASHA10234',
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppColors.secondaryText,
          ),
        ),
        onTap: () {
          if (isDrawer) {
            Navigator.of(context).pop();
          }
          Navigator.of(context).pushNamed(Routes.profile);
        },
      ),
    );
  }

  Widget _buildLogoutTile(BuildContext context) {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.logout_rounded, color: AppColors.deepNavy),
      title: Text(
        'Logout',
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.deepNavy,
        ),
      ),
      onTap: () {
        if (isDrawer) {
          Navigator.of(context).pop();
        }
        AuthService().logout();
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(Routes.landing, (route) => false);
      },
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;
  final String route;

  const _NavItemData(this.icon, this.label, this.route);
}
