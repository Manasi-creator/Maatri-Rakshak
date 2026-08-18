import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/auth/auth_service.dart';
import '../routes.dart';
import '../theme/colors.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final idController = TextEditingController();
    final mobileController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.warmCream,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 900;
                return Row(
                  children: [
                    if (!isCompact)
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(18),
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const _BrandMark(),
                              const SizedBox(height: 24),
                              Container(
                                height: 340,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28),
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.softBlush,
                                      AppColors.lightTeal,
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.favorite_rounded,
                                    size: 180,
                                    color: AppColors.primaryTeal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (!isCompact) const SizedBox(width: 24),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(18),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _BackNavigationButton(
                                onPressed: () {
                                  final navigator = Navigator.of(context);
                                  if (navigator.canPop()) {
                                    navigator.pop();
                                  } else {
                                    navigator.pushReplacementNamed(
                                      Routes.landing,
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 18),
                              Text(
                                'Create Your MaatriRakshak Account',
                                style: GoogleFonts.inter(
                                  fontSize: isCompact ? 28 : 34,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.deepNavy,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'ASHA Worker ID',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: idController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter ASHA Worker ID',
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Full Name',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  hintText: 'Full Name',
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Mobile Number',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: mobileController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  hintText: 'Mobile Number',
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Email (optional)',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: 'Email address',
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Password',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Password',
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Confirm Password',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: confirmController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Confirm Password',
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Preferred Language',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              DropdownButtonFormField<String>(
                                initialValue: 'English',
                                decoration: const InputDecoration(
                                  hintText: 'Select language',
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'English',
                                    child: Text('English'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'मराठी',
                                    child: Text('मराठी'),
                                  ),
                                ],
                                onChanged: (_) {},
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (passwordController.text !=
                                        confirmController.text) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Passwords must match.',
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    await AuthService().signUp(
                                      nameController.text.trim().isEmpty
                                          ? 'ASHA Worker'
                                          : nameController.text.trim(),
                                      emailController.text.trim().isEmpty
                                          ? idController.text.trim()
                                          : emailController.text.trim(),
                                      mobileController.text.trim(),
                                      passwordController.text,
                                    );
                                    if (context.mounted) {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        Routes.dashboard,
                                        (route) => false,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryTeal,
                                    foregroundColor: AppColors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 18,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: const Text('Create Account'),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Text('Already have an account?'),
                                  TextButton(
                                    onPressed: () => Navigator.of(
                                      context,
                                    ).pushNamed(Routes.signIn),
                                    child: const Text('Sign In'),
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
          ),
        ),
      ),
    );
  }
}

class _BackNavigationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _BackNavigationButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_back_rounded, size: 20),
      label: const Text('Back'),
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryTeal,
        padding: EdgeInsets.zero,
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
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
                fontSize: 20,
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
      ],
    );
  }
}
