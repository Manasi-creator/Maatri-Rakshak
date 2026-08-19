import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:printing/printing.dart';

import '../../../models/report_record.dart';
import '../../../services/pdf_report_service.dart';
import '../../../theme/colors.dart';

class DoctorReviewPage extends StatelessWidget {
  final ReportRecord report;
  final VoidCallback onBack;

  const DoctorReviewPage({
    super.key,
    required this.report,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
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
            Text(
              'Doctor Review',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.deepNavy,
              ),
            ),
            const SizedBox(height: 18),
            _Card(
              children: [
                _Info('Patient', report.patientName),
                _Info('Patient ID', report.patientId),
                _Info('Doctor Name', report.doctorName ?? 'Not recorded'),
                _Info('Hospital Name', report.hospitalName ?? 'Not recorded'),
                _Info('Hospital Address', report.hospitalAddress ?? 'Not recorded'),
                _Info('Date and Time', '${_date(report.createdAt)} ${_time(report.createdAt)}'),
              ],
            ),
            _Card(
              title: 'Doctor Observations',
              children: [_Paragraph(report.observations ?? 'No observations recorded.')],
            ),
            _Card(
              title: 'Diagnosis/Clinical Impression',
              children: [_Paragraph(report.clinicalImpression ?? 'Not recorded.')],
            ),
            _Card(
              title: 'Recommended Actions',
              children: [_Paragraph(report.recommendedActions ?? 'Not recorded.')],
            ),
            _Card(
              title: 'Follow-up Date',
              children: [
                _Paragraph(
                  report.followUpDate == null
                      ? 'Not recorded.'
                      : _date(report.followUpDate!),
                ),
              ],
            ),
            _Card(
              title: 'Additional Notes',
              children: [
                _Paragraph(
                  report.notes ??
                      'Information entered by ASHA worker based on doctor communication.',
                ),
              ],
            ),
            OutlinedButton.icon(
              onPressed: () async {
                try {
                  final pdfBytes = await PdfReportService.generateReport(report);
                  final dateStr = '${report.createdAt.year}${report.createdAt.month.toString().padLeft(2, '0')}${report.createdAt.day.toString().padLeft(2, '0')}';
                  final filename = 'MaatriRakshak_${report.patientId}_$dateStr.pdf';
                  await Printing.layoutPdf(
                    onLayout: (format) => pdfBytes,
                    name: filename,
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Unable to generate the report. Please try again. Error: $e'),
                      backgroundColor: AppColors.highRiskRed,
                    ),
                  );
                }
              },
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
  final String? title;
  final List<Widget> children;

  const _Card({this.title, required this.children});

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
          if (title != null) ...[
            Text(
              title!,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.deepNavy,
              ),
            ),
            const SizedBox(height: 12),
          ],
          Wrap(spacing: 18, runSpacing: 12, children: children),
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
      width: 220,
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

String _time(DateTime value) {
  final hour = value.hour > 12 ? value.hour - 12 : value.hour;
  final displayHour = hour == 0 ? 12 : hour;
  final minute = value.minute.toString().padLeft(2, '0');
  final suffix = value.hour >= 12 ? 'PM' : 'AM';
  return '$displayHour:$minute $suffix';
}
