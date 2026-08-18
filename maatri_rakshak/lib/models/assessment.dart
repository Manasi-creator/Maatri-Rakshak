class Assessment {
  final String id;
  final String patientId;
  final String patientName;
  final DateTime date;
  final int riskScore;
  final String urgency;
  final String status;
  final List<String> symptoms;
  final Map<String, String> vitals;
  final List<String> dangerSigns;
  final String? explanation;

  Assessment({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.date,
    required this.riskScore,
    required this.urgency,
    required this.status,
    required this.symptoms,
    required this.vitals,
    required this.dangerSigns,
    this.explanation,
  });

  Assessment copyWith({
    String? id,
    String? patientId,
    String? patientName,
    DateTime? date,
    int? riskScore,
    String? urgency,
    String? status,
    List<String>? symptoms,
    Map<String, String>? vitals,
    List<String>? dangerSigns,
    String? explanation,
  }) {
    return Assessment(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      date: date ?? this.date,
      riskScore: riskScore ?? this.riskScore,
      urgency: urgency ?? this.urgency,
      status: status ?? this.status,
      symptoms: symptoms ?? this.symptoms,
      vitals: vitals ?? this.vitals,
      dangerSigns: dangerSigns ?? this.dangerSigns,
      explanation: explanation ?? this.explanation,
    );
  }
}
