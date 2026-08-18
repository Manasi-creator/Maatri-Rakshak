import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../widgets/authenticated_sidebar.dart';

class AuthenticatedPortalShell extends StatefulWidget {
  final Widget child;
  final String currentRoute;

  const AuthenticatedPortalShell({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  @override
  State<AuthenticatedPortalShell> createState() =>
      _AuthenticatedPortalShellState();
}

class _AuthenticatedPortalShellState extends State<AuthenticatedPortalShell> {
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
      drawer: Drawer(
        width: 260,
        shape: const RoundedRectangleBorder(),
        child: AuthenticatedSidebar(
          currentRoute: widget.currentRoute,
          isDrawer: true,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          return Row(
            children: [
              if (isWide)
                SizedBox(
                  width: 260,
                  child: AuthenticatedSidebar(
                    currentRoute: widget.currentRoute,
                  ),
                ),
              Expanded(child: widget.child),
            ],
          );
        },
      ),
    );
  }
}
