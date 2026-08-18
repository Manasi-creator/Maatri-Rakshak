import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/mock_data.dart';
import '../../../models/report_record.dart';
import '../../../theme/colors.dart';

class CaseSummaryPage extends StatelessWidget {
  final ReportRecord report;
  final VoidCallback onBack;

  const CaseSummaryPage({
    super.key,
    required this.report,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final repo = MockDataRepository.instance();
    final patient = repo.getPatient(report.patientId)!;
    final assessment = repo.getLatestAssessment(report.patientId);
    final vitals = assessment?.vitals ?? patient.currentVitals;
    final dangerSigns = assessment?.dangerSigns ?? [];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Back to Reports'),
            ),
            const SizedBox(height: 8),
            _Title('CASE SUMMARY'),
            const SizedBox(height: 18),
            _Card(
              title: 'Patient Information',
              children: [
                _Info('Patient Name', patient.name),
                _Info('Patient ID', patient.id),
                _Info('Age', '${patient.age}'),
                _Info('Pregnancy Week', 'Week ${patient.pregnancyWeek}'),
                _Info(
                  'Expected Delivery Date',
                  patient.expectedDeliveryDate == null
                      ? 'Not recorded'
                      : _date(patient.expectedDeliveryDate!),
                ),
              ],
            ),
            _Card(
              title: 'Current Health Status',
              children: [
                _Info('Blood Pressure', vitals['bloodPressure'] ?? '-'),
                _Info('Haemoglobin', vitals['haemoglobin'] ?? '-'),
                _Info('Temperature', vitals['temperature'] ?? '-'),
                _Info('Pulse', vitals['pulse'] ?? '-'),
                _Info('Risk Score', '${assessment?.riskScore ?? patient.riskScore}/100'),
                _Info('Risk Level', patient.riskLevel),
                _Info('Urgency', assessment?.urgency ?? 'Suggested follow-up'),
              ],
            ),
            _Card(
              title: 'Identified Danger Signs',
              children: dangerSigns.isEmpty
                  ? [_Info('Danger Signs', 'No danger signs recorded')]
                  : dangerSigns.map((sign) => _Info('Danger Sign', sign)).toList(),
            ),
            _Card(
              title: 'AI-Assisted Assessment Summary',
              children: const [
                _Paragraph(
                  'Recorded symptoms and vital measurements indicate elevated maternal risk requiring timely medical review.',
                ),
                _Paragraph(
                  'Why this result? Risk screening considers current vitals, reported symptoms, pregnancy history, and identified danger signs.',
                ),
                _Paragraph(
                  'Decision-support information only. Follow approved clinical protocols and professional medical advice.',
                ),
              ],
            ),
            OutlinedButton.icon(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Prototype PDF download prepared.')),
              ),
              icon: const Icon(Icons.download_rounded),
              label: const Text('Download PDF'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Card({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Title(title, small: true),
          const SizedBox(height: 12),
          Wrap(spacing: 18, runSpacing: 12, children: children),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String text;
  final bool small;

  const _Title(this.text, {this.small = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: small ? 18 : 28,
        fontWeight: FontWeight.w800,
        color: AppColors.deepNavy,
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
      width: 210,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 12, color: AppColors.secondaryText)),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.deepNavy,
            ),
          ),
        ],
      ),
    );
  }
}

class _Paragraph extends StatelessWidget {
  final String text;

  const _Paragraph(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 14,
        height: 1.5,
        color: AppColors.primaryText,
      ),
    );
  }
}

String _date(DateTime value) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${value.day} ${months[value.month - 1]} ${value.year}';
}
