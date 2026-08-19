import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:printing/printing.dart';

import '../../../data/mock_data.dart';
import '../../../models/report_record.dart';
import '../../../services/pdf_report_service.dart';
import '../../../theme/colors.dart';
import 'case_summary_page.dart';
import 'doctor_review_page.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final _repo = MockDataRepository.instance();
  ReportRecord? _selectedReport;

  @override
  Widget build(BuildContext context) {
    if (_selectedReport != null) {
      if (_selectedReport!.type == 'Doctor Review') {
        return DoctorReviewPage(
          report: _selectedReport!,
          onBack: () => setState(() => _selectedReport = null),
        );
      }
      return CaseSummaryPage(
        report: _selectedReport!,
        onBack: () => setState(() => _selectedReport = null),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reports',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.deepNavy,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'View patient case summaries and medical reviews.',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 22),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: TabBar(
                labelColor: AppColors.primaryTeal,
                unselectedLabelColor: AppColors.secondaryText,
                indicatorColor: AppColors.primaryTeal,
                tabs: const [
                  Tab(text: 'Case Summary'),
                  Tab(text: 'Doctor Review'),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: AnimatedBuilder(
                animation: _repo,
                builder: (context, _) {
                  final caseSummaries = _repo.reports
                      .where((report) => report.type == 'Case Summary')
                      .toList();
                  final doctorReviews = _repo.reports
                      .where((report) => report.type == 'Doctor Review')
                      .toList();
                  return TabBarView(
                    children: [
                      _ReportList(
                        reports: caseSummaries,
                        actionLabel: 'View Report',
                        onView: (report) =>
                            setState(() => _selectedReport = report),
                      ),
                      _ReportList(
                        reports: doctorReviews,
                        actionLabel: 'View Review',
                        onView: (report) =>
                            setState(() => _selectedReport = report),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportList extends StatelessWidget {
  final List<ReportRecord> reports;
  final String actionLabel;
  final ValueChanged<ReportRecord> onView;

  const _ReportList({
    required this.reports,
    required this.actionLabel,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: reports
            .map(
              (report) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 18,
                      runSpacing: 10,
                      children: [
                        _Info('Report Type', report.type),
                        _Info('Patient Name', report.patientName),
                        _Info('Patient ID', report.patientId),
                        _Info('Date', _date(report.createdAt)),
                        _Info('Time', _time(report.createdAt)),
                        _Info('Created By', report.createdBy),
                        _Info('Status', report.status),
                        if (report.doctorName != null)
                          _Info('Doctor', report.doctorName!),
                        if (report.hospitalName != null)
                          _Info('Hospital', report.hospitalName!),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ElevatedButton(
                          onPressed: () => onView(report),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryTeal,
                            foregroundColor: AppColors.white,
                          ),
                          child: Text(actionLabel),
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
                  ],
                ),
              ),
            )
            .toList(),
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
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 12, color: AppColors.secondaryText),
          ),
          const SizedBox(height: 3),
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
