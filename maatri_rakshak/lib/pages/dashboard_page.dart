import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';
import '../widgets/sidebar.dart';

/// ASHA Worker Portal dashboard page.
class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ASHA Worker Portal'),
        backgroundColor: AppColors.primaryTeal,
      ),
      drawer: SidebarDrawer(
        onSelect: (route) => Navigator.of(context).pushNamed(route),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ASHA Worker',
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepNavy,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Use the sidebar to navigate to different sections.',
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryText,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _DashboardCard(
                    icon: Icons.pregnant_woman,
                    label: 'Assess Mother',
                    color: AppColors.primaryTeal,
                    onTap: () => Navigator.pushNamed(context, '/assessment'),
                  ),
                  _DashboardCard(
                    icon: Icons.history,
                    label: 'Case History',
                    color: AppColors.deepNavy,
                    onTap: () => Navigator.pushNamed(context, '/history'),
                  ),
                  _DashboardCard(
                    icon: Icons.local_hospital,
                    label: 'Emergency Help',
                    color: AppColors.softCoralPink,
                    onTap: () => Navigator.pushNamed(context, '/emergency'),
                  ),
                  _DashboardCard(
                    icon: Icons.settings,
                    label: 'Settings',
                    color: AppColors.warmPeach,
                    onTap: () => Navigator.pushNamed(context, '/settings'),
                  ),
                ],
              ),
            ),
          ],
        ),
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
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 48),
            const SizedBox(height: 12),
            Text(
              label,
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
