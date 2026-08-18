class ReportRecord {
  final String id;
  final String type;
  final String patientId;
  final String patientName;
  final DateTime createdAt;
  final String createdBy;
  final String status;
  final String? doctorName;
  final String? hospitalName;
  final String? hospitalAddress;
  final String? observations;
  final String? clinicalImpression;
  final String? recommendedActions;
  final DateTime? followUpDate;
  final String? notes;

  ReportRecord({
    required this.id,
    required this.type,
    required this.patientId,
    required this.patientName,
    required this.createdAt,
    required this.createdBy,
    required this.status,
    this.doctorName,
    this.hospitalName,
    this.hospitalAddress,
    this.observations,
    this.clinicalImpression,
    this.recommendedActions,
    this.followUpDate,
    this.notes,
  });
}
