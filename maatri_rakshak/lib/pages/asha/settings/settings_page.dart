import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/auth/auth_service.dart';
import '../../../routes.dart';
import '../../../theme/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _currentPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();
  String _language = 'English';
  bool _medicalOfficerAlerts = true;
  bool _transportUpdates = true;
  bool _assessmentReminders = false;
  bool _caseStatusUpdates = true;
  bool _offlineMode = true;

  @override
  void dispose() {
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _updatePassword() {
    if (_newPassword.text.isEmpty || _confirmPassword.text.isEmpty) {
      _snack('New password and confirmation are required.');
      return;
    }
    if (_newPassword.text != _confirmPassword.text) {
      _snack('Passwords must match.');
      return;
    }
    _currentPassword.clear();
    _newPassword.clear();
    _confirmPassword.clear();
    _snack('Password updated successfully.');
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.highRiskRed,
              foregroundColor: AppColors.white,
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      AuthService().logout();
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.landing,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.deepNavy,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Manage your account and application preferences.',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 22),
            _Section(
              title: 'Account',
              children: [
                _Info('Profile Name', 'Sunita Patil'),
                _Info('ASHA Worker ID', 'ASHA10234'),
                _Info('Mobile Number', '+91 XXXXX XXXXX'),
                _Info('Email', 'sunita.patil@example.com'),
                _Info('Assigned Area', 'Pune District'),
                OutlinedButton(
                  onPressed: () => _snack('Profile edits saved locally.'),
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
            _Section(
              title: 'Security',
              children: [
                _PasswordField(controller: _currentPassword, label: 'Current Password'),
                _PasswordField(controller: _newPassword, label: 'New Password'),
                _PasswordField(
                  controller: _confirmPassword,
                  label: 'Confirm New Password',
                ),
                ElevatedButton(
                  onPressed: _updatePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryTeal,
                    foregroundColor: AppColors.white,
                  ),
                  child: const Text('Update Password'),
                ),
              ],
            ),
            _Section(
              title: 'Language',
              children: [
                _LanguageOption(
                  label: 'English',
                  selected: _language == 'English',
                  onTap: () => setState(() => _language = 'English'),
                ),
                _LanguageOption(
                  label: 'Marathi',
                  selected: _language == 'Marathi',
                  onTap: () => setState(() => _language = 'Marathi'),
                ),
              ],
            ),
            _Section(
              title: 'Notifications',
              children: [
                _SwitchTile(
                  label: 'Medical Officer Alerts',
                  value: _medicalOfficerAlerts,
                  onChanged: (value) => setState(() => _medicalOfficerAlerts = value),
                ),
                _SwitchTile(
                  label: 'Transport Updates',
                  value: _transportUpdates,
                  onChanged: (value) => setState(() => _transportUpdates = value),
                ),
                _SwitchTile(
                  label: 'Assessment Reminders',
                  value: _assessmentReminders,
                  onChanged: (value) => setState(() => _assessmentReminders = value),
                ),
                _SwitchTile(
                  label: 'Case Status Updates',
                  value: _caseStatusUpdates,
                  onChanged: (value) => setState(() => _caseStatusUpdates = value),
                ),
              ],
            ),
            _Section(
              title: 'Application',
              children: [
                Text(
                  'Data will be stored locally when internet is unavailable.',
                  style: GoogleFonts.inter(color: AppColors.secondaryText),
                ),
                _SwitchTile(
                  label: 'Offline-first mode',
                  value: _offlineMode,
                  onChanged: (value) => setState(() => _offlineMode = value),
                ),
                _Info('Last Sync', '18 Aug 2026, 10:40 AM'),
                _Info('Sync Status', _offlineMode ? 'Synced' : 'Waiting for connection'),
              ],
            ),
            _Section(
              title: 'About',
              children: const [
                _Info('MaatriRakshak', 'Offline-first maternal emergency support for ASHA workers.'),
                _Info('Version', '1.0.0'),
                _Info('Prototype', 'Hackathon Round 2'),
                _Info(
                  'Disclaimer',
                  'MaatriRakshak is a decision-support prototype intended to assist ASHA workers. It does not replace qualified medical professionals or approved clinical protocols.',
                ),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Log Out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.highRiskRed,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.deepNavy,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(spacing: 14, runSpacing: 12, children: children),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final String label;
  final String value;

  const _Info(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: label == 'Disclaimer' ? 620 : 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 12, color: AppColors.secondaryText)),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              height: 1.4,
              fontWeight: FontWeight.w700,
              color: AppColors.deepNavy,
            ),
          ),
        ],
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const _PasswordField({required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: AppColors.lightTeal,
      labelStyle: GoogleFonts.inter(
        color: selected ? AppColors.primaryTeal : AppColors.deepNavy,
        fontWeight: FontWeight.w700,
      ),
      side: BorderSide(
        color: selected ? AppColors.primaryTeal : AppColors.border,
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.deepNavy,
          ),
        ),
        value: value,
        activeThumbColor: AppColors.primaryTeal,
        onChanged: onChanged,
      ),
    );
  }
}
