import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/mock_data.dart';
import '../../models/patient.dart';
import '../../theme/colors.dart';

class AddPatientPage extends StatefulWidget {
  const AddPatientPage({super.key});

  @override
  State<AddPatientPage> createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _pregnancyWeekController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _riskScoreController = TextEditingController();

  String _selectedBloodGroup = 'O+';
  String _selectedRiskLevel = 'Stable';
  bool _isSaving = false;

  final List<String> _bloodGroups = [
    'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-',
  ];

  final List<String> _riskLevels = [
    'Stable', 'Needs Review', 'High', 'Emergency',
  ];

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _pregnancyWeekController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _riskScoreController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = MockDataRepository.instance();

    // Check duplicate ID
    final existingPatient = repo.getPatient(_idController.text.trim());
    if (existingPatient != null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Patient ID ${_idController.text.trim()} already exists.',
            style: GoogleFonts.inter(color: AppColors.white),
          ),
          backgroundColor: AppColors.highRiskRed,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    final patient = Patient(
      id: _idController.text.trim(),
      name: _nameController.text.trim(),
      age: int.parse(_ageController.text.trim()),
      pregnancyWeek: int.parse(_pregnancyWeekController.text.trim()),
      bloodGroup: _selectedBloodGroup,
      address: _addressController.text.trim(),
      phone: _phoneController.text.trim(),
      lastAssessment: DateTime.now(),
      riskLevel: _selectedRiskLevel,
      riskScore: int.tryParse(_riskScoreController.text.trim()) ?? 0,
    );

    repo.addPatient(patient);

    setState(() => _isSaving = false);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Patient ${patient.name} added successfully.',
          style: GoogleFonts.inter(color: AppColors.white),
        ),
        backgroundColor: AppColors.lowRiskGreen,
      ),
    );
    Navigator.of(context).pop(true); // pop with result=true so caller can refresh
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      appBar: AppBar(
        title: Text(
          'Add Patient',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.deepNavy,
          ),
        ),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.deepNavy,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Patient Information',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepNavy,
                ),
              ),
              const SizedBox(height: 16),
              _buildCard([
                _buildField(
                  controller: _idController,
                  label: 'Patient ID',
                  hint: 'e.g. 10999',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Patient ID is required';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildField(
                  controller: _nameController,
                  label: 'Full Name',
                  hint: 'e.g. Anita Sharma',
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Name is required';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildField(
                        controller: _ageController,
                        label: 'Age',
                        hint: 'e.g. 25',
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Age required';
                          final age = int.tryParse(v.trim());
                          if (age == null || age < 10 || age > 60) return 'Invalid age';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildField(
                        controller: _pregnancyWeekController,
                        label: 'Pregnancy Week',
                        hint: 'e.g. 28',
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Week required';
                          final w = int.tryParse(v.trim());
                          if (w == null || w < 1 || w > 42) return 'Invalid week (1–42)';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildField(
                  controller: _phoneController,
                  label: 'Contact Number',
                  hint: 'e.g. 9876543210',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Phone is required';
                    if (v.trim().length < 10) return 'Enter a valid phone number';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildField(
                  controller: _addressController,
                  label: 'Address / Location',
                  hint: 'e.g. Shivaji Nagar, Pune',
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Address is required';
                    return null;
                  },
                ),
              ]),
              const SizedBox(height: 20),
              Text(
                'Medical Information',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepNavy,
                ),
              ),
              const SizedBox(height: 16),
              _buildCard([
                _buildDropdown(
                  label: 'Blood Group',
                  value: _selectedBloodGroup,
                  items: _bloodGroups,
                  onChanged: (v) => setState(() => _selectedBloodGroup = v!),
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Risk Level',
                  value: _selectedRiskLevel,
                  items: _riskLevels,
                  onChanged: (v) => setState(() => _selectedRiskLevel = v!),
                  itemColors: {
                    'Stable': AppColors.lowRiskGreen,
                    'Needs Review': AppColors.mediumRiskOrange,
                    'High': AppColors.highRiskRed,
                    'Emergency': AppColors.emergencyRed,
                  },
                ),
                const SizedBox(height: 16),
                _buildField(
                  controller: _riskScoreController,
                  label: 'Risk Score (0–100)',
                  hint: 'e.g. 45',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Risk score required';
                    final s = int.tryParse(v.trim());
                    if (s == null || s < 0 || s > 100) return 'Score must be 0–100';
                    return null;
                  },
                ),
              ]),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryTeal,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    disabledBackgroundColor: AppColors.primaryTeal.withValues(alpha: 0.5),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                          ),
                        )
                      : Text(
                          'Save Patient',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.deepNavy,
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.deepNavy,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.primaryText,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.secondaryText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    Map<String, Color>? itemColors,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.deepNavy,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
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
            filled: true,
            fillColor: AppColors.white,
          ),
          style: GoogleFonts.inter(
            fontSize: 14,
            color: itemColors != null
                ? (itemColors[value] ?? AppColors.primaryText)
                : AppColors.primaryText,
          ),
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: itemColors != null
                          ? (itemColors[item] ?? AppColors.primaryText)
                          : AppColors.primaryText,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
