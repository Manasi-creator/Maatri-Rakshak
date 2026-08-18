class Patient {
  final String id;
  final String name;
  final int age;
  final int pregnancyWeek;
  final String bloodGroup;
  final String address;
  final String phone;
  final DateTime lastAssessment;
  final String riskLevel;
  final int riskScore;
  final DateTime? expectedDeliveryDate;
  final int? previousPregnancies;
  final List<String> previousComplications;
  final List<String> medicalConditions;
  final Map<String, String> currentVitals;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.pregnancyWeek,
    required this.bloodGroup,
    required this.address,
    required this.phone,
    required this.lastAssessment,
    required this.riskLevel,
    required this.riskScore,
    this.expectedDeliveryDate,
    this.previousPregnancies,
    this.previousComplications = const [],
    this.medicalConditions = const [],
    this.currentVitals = const {},
  });

  Patient copyWith({
    String? id,
    String? name,
    int? age,
    int? pregnancyWeek,
    String? bloodGroup,
    String? address,
    String? phone,
    DateTime? lastAssessment,
    String? riskLevel,
    int? riskScore,
    DateTime? expectedDeliveryDate,
    int? previousPregnancies,
    List<String>? previousComplications,
    List<String>? medicalConditions,
    Map<String, String>? currentVitals,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      pregnancyWeek: pregnancyWeek ?? this.pregnancyWeek,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      lastAssessment: lastAssessment ?? this.lastAssessment,
      riskLevel: riskLevel ?? this.riskLevel,
      riskScore: riskScore ?? this.riskScore,
      expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
      previousPregnancies: previousPregnancies ?? this.previousPregnancies,
      previousComplications:
          previousComplications ?? this.previousComplications,
      medicalConditions: medicalConditions ?? this.medicalConditions,
      currentVitals: currentVitals ?? this.currentVitals,
    );
  }
}
