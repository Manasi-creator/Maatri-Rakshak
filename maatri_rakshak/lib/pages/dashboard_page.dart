import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../routes.dart';
import '../theme/colors.dart';
import '../widgets/sidebar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      appBar: AppBar(
        title: const Text('ASHA Worker Portal'),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.deepNavy,
        elevation: 0,
      ),
      drawer: SidebarDrawer(
        onSelect: (route) => Navigator.of(context).pushNamed(route),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          return Row(
            children: [
              if (isWide)
                const SizedBox(width: 260, child: _DashboardSidebar()),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, ASHA Worker',
                          style: GoogleFonts.inter(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: AppColors.deepNavy,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Use the sidebar to navigate to different sections.',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: AppColors.secondaryText,
                          ),
                        ),
                        const SizedBox(height: 28),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: isWide ? 2 : 1,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.55,
                          children: [
                            _DashboardCard(
                              icon: Icons.pregnant_woman_rounded,
                              label: 'Assess Mother',
                              color: AppColors.primaryTeal,
                              onTap: () =>
                                  Navigator.pushNamed(context, '/assessment'),
                            ),
                            _DashboardCard(
                              icon: Icons.history_rounded,
                              label: 'Case History',
                              color: AppColors.deepNavy,
                              onTap: () =>
                                  Navigator.pushNamed(context, '/history'),
                            ),
                            _DashboardCard(
                              icon: Icons.local_hospital_rounded,
                              label: 'Emergency Help',
                              color: AppColors.softCoralPink,
                              onTap: () =>
                                  Navigator.pushNamed(context, '/emergency'),
                            ),
                            _DashboardCard(
                              icon: Icons.settings_rounded,
                              label: 'Settings',
                              color: AppColors.warmPeach,
                              onTap: () =>
                                  Navigator.pushNamed(context, '/settings'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DashboardSidebar extends StatelessWidget {
  const _DashboardSidebar();

  @override
  Widget build(BuildContext context) {
    final items = [
      _SidebarItem(
        icon: Icons.dashboard_rounded,
        label: 'Dashboard',
        route: Routes.dashboard,
      ),
      _SidebarItem(
        icon: Icons.group_rounded,
        label: 'Patients',
        route: Routes.dashboard,
      ),
      _SidebarItem(
        icon: Icons.assignment_rounded,
        label: 'Assessments',
        route: Routes.dashboard,
      ),
      _SidebarItem(
        icon: Icons.local_hospital_rounded,
        label: 'Facilities',
        route: Routes.dashboard,
      ),
      _SidebarItem(
        icon: Icons.airport_shuttle_rounded,
        label: 'Transport',
        route: Routes.dashboard,
      ),
      _SidebarItem(
        icon: Icons.bar_chart_rounded,
        label: 'Reports',
        route: Routes.dashboard,
      ),
      _SidebarItem(
        icon: Icons.timeline_rounded,
        label: 'Timeline',
        route: Routes.dashboard,
      ),
      _SidebarItem(
        icon: Icons.settings_rounded,
        label: 'Settings',
        route: Routes.dashboard,
      ),
    ];

    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const _DashboardBrandMark(),
          const SizedBox(height: 24),
          ...items.map((item) => item),
          const Spacer(),
          const Divider(),
          _SidebarItem(
            icon: Icons.language_rounded,
            label: 'Language',
            route: Routes.dashboard,
          ),
          _SidebarItem(
            icon: Icons.help_outline_rounded,
            label: 'Help',
            route: Routes.dashboard,
          ),
          _SidebarItem(
            icon: Icons.person_rounded,
            label: 'Profile',
            route: Routes.dashboard,
          ),
          _SidebarItem(
            icon: Icons.logout_rounded,
            label: 'Logout',
            route: Routes.landing,
          ),
        ],
      ),
    );
  }
}

class _DashboardBrandMark extends StatelessWidget {
  const _DashboardBrandMark();

  @override
  Widget build(BuildContext context) {
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
        Column(
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
              'Care coordination',
              style: GoogleFonts.inter(
                fontSize: 10,
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = route == Routes.dashboard && label == 'Dashboard';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
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

class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppColors.white, size: 38),
              const Spacer(),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
