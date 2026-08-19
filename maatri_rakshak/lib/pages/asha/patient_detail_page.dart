import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/mock_data.dart';
import '../../models/assessment.dart';
import '../../models/patient.dart';
import '../../models/report_record.dart';
import '../../models/timeline_event.dart';
import '../../theme/colors.dart';

class PatientDetailPage extends StatelessWidget {
  final Patient patient;
  final Assessment? selectedAssessment;

  const PatientDetailPage({
    super.key,
    required this.patient,
    this.selectedAssessment,
  });

  @override
  Widget build(BuildContext context) {
    final dataRepo = MockDataRepository.instance();
    final assessments = dataRepo.getPatientAssessments(patient.id);
    final reports = dataRepo.reports.where((r) => r.patientId == patient.id).toList();
    final timelineEvents = dataRepo.timelineEvents.where((e) => e.patientId == patient.id).toList();

    return Scaffold(
      backgroundColor: AppColors.warmCream,
      appBar: AppBar(
        title: Text(
          patient.name,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selected Assessment Warning/Highlight Banner if present
            if (selectedAssessment != null) ...[
              _buildAssessmentHighlightBanner(context, selectedAssessment!),
              const SizedBox(height: 16),
            ],

            // Patient Header Card (Profile Summary)
            _buildProfileSummaryCard(),
            const SizedBox(height: 24),

            // Pregnancy and Medical Profile Card
            _buildPregnancyMedicalCard(),
            const SizedBox(height: 24),

            // Vitals Card
            _buildVitalsCard(),
            const SizedBox(height: 24),

            // Assessments Card
            _buildAssessmentsCard(context, assessments),
            const SizedBox(height: 24),

            // Reports Card
            _buildReportsCard(reports),
            const SizedBox(height: 24),

            // Timeline Card
            _buildTimelineCard(timelineEvents),
          ],
        ),
      ),
    );
  }

  Widget _buildAssessmentHighlightBanner(BuildContext context, Assessment assessment) {
    final riskColor = _getUrgencyColor(assessment.urgency);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: riskColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: riskColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_rounded, color: riskColor, size: 20),
              const SizedBox(width: 8),
              Text(
                'Arrived from Assessment View',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: riskColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Urgency: ${assessment.urgency} (Risk Score: ${assessment.riskScore}/100)',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: AppColors.deepNavy,
            ),
          ),
          if (assessment.explanation != null) ...[
            const SizedBox(height: 4),
            Text(
              'Observation: ${assessment.explanation}',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.secondaryText,
              ),
            ),
          ],
          if (assessment.dangerSigns.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Danger Signs: ${assessment.dangerSigns.join(", ")}',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: AppColors.highRiskRed,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProfileSummaryCard() {
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                patient.name,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.deepNavy,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _getRiskColor(patient.riskLevel).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  patient.riskLevel,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _getRiskColor(patient.riskLevel),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.badge_rounded, 'Patient ID', patient.id),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.cake_rounded, 'Age', '${patient.age} years old'),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.phone_rounded, 'Contact', patient.phone),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.location_on_rounded, 'Address', patient.address),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.water_drop_rounded, 'Blood Group', patient.bloodGroup),
        ],
      ),
    );
  }

  Widget _buildPregnancyMedicalCard() {
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
        children: [
          Text(
            'Pregnancy & Medical History',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.deepNavy,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.calendar_today_rounded, 'Pregnancy Progress', 'Week ${patient.pregnancyWeek}'),
          if (patient.expectedDeliveryDate != null) ...[
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.baby_changing_station_rounded,
              'Expected Delivery Date',
              '${patient.expectedDeliveryDate!.day} ${_getMonth(patient.expectedDeliveryDate!.month)}, ${patient.expectedDeliveryDate!.year}',
            ),
          ],
          const SizedBox(height: 8),
          _buildInfoRow(Icons.child_care_rounded, 'Previous Pregnancies', '${patient.previousPregnancies ?? 0}'),
          if (patient.previousComplications.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Previous Complications:',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.deepNavy,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              patient.previousComplications.join(', '),
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.highRiskRed,
              ),
            ),
          ],
          if (patient.medicalConditions.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Chronic Medical Conditions:',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.deepNavy,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              patient.medicalConditions.join(', '),
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.deepNavy,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVitalsCard() {
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
        children: [
          Text(
            'Current Vitals',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.deepNavy,
            ),
          ),
          const SizedBox(height: 16),
          if (patient.currentVitals.isEmpty)
            Text(
              'No vitals recorded.',
              style: GoogleFonts.inter(fontSize: 14, color: AppColors.secondaryText),
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 400;
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: isWide ? 4 : 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.3,
                  children: [
                    _buildVitalItem('BP', patient.currentVitals['bloodPressure'] ?? 'N/A', Icons.favorite_rounded, AppColors.highRiskRed),
                    _buildVitalItem('Hb', '${patient.currentVitals['haemoglobin'] ?? 'N/A'} g/dL', Icons.bloodtype_rounded, AppColors.softCoralPink),
                    _buildVitalItem('Temp', '${patient.currentVitals['temperature'] ?? 'N/A'} °F', Icons.thermostat_rounded, AppColors.warmPeach),
                    _buildVitalItem('Pulse', '${patient.currentVitals['pulse'] ?? 'N/A'} bpm', Icons.favorite_border_rounded, AppColors.primaryTeal),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildVitalItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.deepNavy,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentsCard(BuildContext context, List<Assessment> assessments) {
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
        children: [
          Text(
            'Maternal Assessments History',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.deepNavy,
            ),
          ),
          const SizedBox(height: 16),
          if (assessments.isEmpty)
            Text(
              'No assessments recorded yet.',
              style: GoogleFonts.inter(fontSize: 14, color: AppColors.secondaryText),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: assessments.length,
              separatorBuilder: (context, index) => const Divider(color: AppColors.border, height: 16),
              itemBuilder: (context, index) {
                final assessment = assessments[index];
                final isSelected = selectedAssessment?.id == assessment.id;

                return Container(
                  padding: isSelected ? const EdgeInsets.all(8) : null,
                  decoration: isSelected
                      ? BoxDecoration(
                          color: AppColors.lightTeal.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.primaryTeal.withValues(alpha: 0.3)),
                        )
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date: ${assessment.date.day} ${_getMonth(assessment.date.month)}, ${assessment.date.year}',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.deepNavy,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Risk Score: ${assessment.riskScore}/100 • Urgency: ${assessment.urgency}',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.secondaryText,
                              ),
                            ),
                            if (assessment.explanation != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                assessment.explanation!,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: AppColors.primaryText,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getUrgencyColor(assessment.urgency).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          assessment.urgency,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _getUrgencyColor(assessment.urgency),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildReportsCard(List<ReportRecord> reports) {
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
        children: [
          Text(
            'Reports & Clinical Summaries',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.deepNavy,
            ),
          ),
          const SizedBox(height: 16),
          if (reports.isEmpty)
            Text(
              'No reports available.',
              style: GoogleFonts.inter(fontSize: 14, color: AppColors.secondaryText),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reports.length,
              separatorBuilder: (context, index) => const Divider(color: AppColors.border, height: 16),
              itemBuilder: (context, index) {
                final report = reports[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          report.type,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.deepNavy,
                          ),
                        ),
                        Text(
                          '${report.createdAt.day} ${_getMonth(report.createdAt.month)}, ${report.createdAt.year}',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (report.doctorName != null) ...[
                      Text(
                        'By: ${report.doctorName} (${report.hospitalName ?? ""})',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryTeal,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    if (report.observations != null) ...[
                      Text(
                        'Observations: ${report.observations}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                    if (report.recommendedActions != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Recommendations: ${report.recommendedActions}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.lowRiskGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard(List<TimelineEvent> events) {
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
        children: [
          Text(
            'Patient Timeline',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.deepNavy,
            ),
          ),
          const SizedBox(height: 16),
          if (events.isEmpty)
            Text(
              'No timeline events.',
              style: GoogleFonts.inter(fontSize: 14, color: AppColors.secondaryText),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryTeal,
                            shape: BoxShape.circle,
                          ),
                        ),
                        if (index < events.length - 1)
                          Container(
                            width: 2,
                            height: 32,
                            color: AppColors.border,
                          ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.eventType,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.deepNavy,
                            ),
                          ),
                          Text(
                            '${event.timestamp.day} ${_getMonth(event.timestamp.month)}, ${event.timestamp.year} • ${event.timestamp.hour.toString().padLeft(2, '0')}:${event.timestamp.minute.toString().padLeft(2, '0')}',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: AppColors.secondaryText,
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.primaryTeal),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.deepNavy,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.secondaryText,
            ),
          ),
        ),
      ],
    );
  }

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel) {
      case 'Stable':
        return AppColors.lowRiskGreen;
      case 'Needs Review':
        return AppColors.mediumRiskOrange;
      case 'High':
        return AppColors.highRiskRed;
      case 'Emergency':
        return AppColors.emergencyRed;
      default:
        return AppColors.deepNavy;
    }
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case 'Routine':
        return AppColors.lowRiskGreen;
      case 'Medical Review':
        return AppColors.mediumRiskOrange;
      case 'High Priority':
        return AppColors.highRiskRed;
      case 'Immediate Attention':
        return AppColors.emergencyRed;
      default:
        return AppColors.deepNavy;
    }
  }

  String _getMonth(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
