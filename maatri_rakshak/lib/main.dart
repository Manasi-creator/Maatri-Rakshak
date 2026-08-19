import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/auth/auth_service.dart';
import 'data/mock_data.dart';
import 'layouts/authenticated_portal_shell.dart';
import 'pages/landing_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/sign_up_page.dart';
import 'pages/asha/dashboard_page.dart';
import 'pages/asha/patients_page.dart';
import 'pages/asha/assessments_page.dart';
import 'pages/asha/facilities_page.dart';
import 'pages/asha/reports/reports_page.dart';
import 'pages/asha/settings/settings_page.dart';
import 'pages/asha/language/language_page.dart';
import 'pages/asha/help/help_page.dart';
import 'pages/asha/profile/profile_page.dart';
import 'pages/asha/timeline/timeline_page.dart';
import 'pages/asha/transport/transport_page.dart';
import 'pages/asha/add_patient_page.dart';
import 'pages/asha/patient_detail_page.dart';
import 'models/patient.dart';
import 'models/assessment.dart';
import 'routes.dart';
import 'theme/colors.dart';

void main() {
  // Initialize singleton for mock data
  MockDataRepository.instance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthService _authService;
  late VoidCallback _authListener;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    _authListener = () {
      setState(() {});
    };
    _authService.addListener(_authListener);
  }

  @override
  void dispose() {
    _authService.removeListener(_authListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaatriRakshak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.warmCream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryTeal,
          primary: AppColors.primaryTeal,
          secondary: AppColors.deepNavy,
          surface: AppColors.warmCream,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.primaryText,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.primaryTeal,
              width: 2,
            ),
          ),
        ),
      ),
      initialRoute: Routes.landing,
      routes: {
        Routes.landing: (_) => const LandingPageWidget(),
        Routes.signIn: (_) => const SignInPage(),
        Routes.signUp: (_) => const SignUpPage(),
      },
      onGenerateRoute: (settings) {
        // Only allow authenticated routes if user is authenticated
        if (!_authService.isAuthenticated) {
          // Redirect to landing page for any authenticated route when not logged in
          if (settings.name == Routes.landing ||
              settings.name == Routes.signIn ||
              settings.name == Routes.signUp) {
            return null; // Use predefined routes
          }
          // Redirect all other routes to landing
          return MaterialPageRoute(builder: (_) => const LandingPageWidget());
        }

        // Handle authenticated routes
        switch (settings.name) {
          case Routes.dashboard:
            return MaterialPageRoute(
              builder: (_) => AuthenticatedPortalShell(
                currentRoute: Routes.dashboard,
                child: const DashboardPage(),
              ),
            );
          case Routes.patients:
            return MaterialPageRoute(
              builder: (_) => AuthenticatedPortalShell(
                currentRoute: Routes.patients,
                child: const PatientsPage(),
              ),
            );
          case Routes.assessments:
            return MaterialPageRoute(
              builder: (_) => AuthenticatedPortalShell(
                currentRoute: Routes.assessments,
                child: const AssessmentsPage(),
              ),
            );
          case Routes.facilities:
            return MaterialPageRoute(
              builder: (_) => AuthenticatedPortalShell(
                currentRoute: Routes.facilities,
                child: const FacilitiesPage(),
              ),
            );
          case Routes.transport:
            return MaterialPageRoute(
              builder: (_) => AuthenticatedPortalShell(
                currentRoute: Routes.transport,
                child: const TransportPage(),
              ),
            );
          case Routes.reports:
            return MaterialPageRoute(
              builder: (_) => AuthenticatedPortalShell(
                currentRoute: Routes.reports,
                child: const ReportsPage(),
              ),
            );
          case Routes.timeline:
            return MaterialPageRoute(
              builder: (_) => AuthenticatedPortalShell(
                currentRoute: Routes.timeline,
                child: const TimelinePage(),
              ),
            );
          case Routes.settings:
            return MaterialPageRoute(
              builder: (_) => AuthenticatedPortalShell(
                currentRoute: Routes.settings,
                child: const SettingsPage(),
              ),
            );
          case Routes.language:
            return MaterialPageRoute(
              builder: (_) => AuthenticatedPortalShell(
                currentRoute: Routes.language,
                child: const LanguagePage(),
              ),
            );
          case Routes.help:
            return MaterialPageRoute(
              builder: (_) => AuthenticatedPortalShell(
                currentRoute: Routes.help,
                child: const HelpPage(),
              ),
            );
          case Routes.profile:
            return MaterialPageRoute(
              builder: (_) => AuthenticatedPortalShell(
                currentRoute: Routes.profile,
                child: const ProfilePage(),
              ),
            );
          case Routes.addPatient:
            return MaterialPageRoute(
              builder: (_) => const AddPatientPage(),
            );
          case Routes.patientDetail:
            final args = settings.arguments;
            Patient patient;
            Assessment? assessment;
            if (args is Patient) {
              patient = args;
            } else if (args is Map<String, dynamic>) {
              patient = args['patient'] as Patient;
              assessment = args['assessment'] as Assessment?;
            } else {
              return MaterialPageRoute(
                builder: (_) => const Scaffold(
                  body: Center(child: Text('Invalid arguments')),
                ),
              );
            }
            return MaterialPageRoute(
              builder: (_) => PatientDetailPage(
                patient: patient,
                selectedAssessment: assessment,
              ),
            );
        }
        return null;
      },
    );
  }
}
