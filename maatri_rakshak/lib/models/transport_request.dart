class TransportRequest {
  final String id;
  final String patientId;
  final String patientName;
  final String pickupLocation;
  final String destinationFacilityId;
  final String destinationName;
  final String transportType;
  final String vehicleInfo;
  final String status;
  final String eta;
  final DateTime requestedAt;
  final DateTime lastUpdated;

  TransportRequest({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.pickupLocation,
    required this.destinationFacilityId,
    required this.destinationName,
    required this.transportType,
    required this.vehicleInfo,
    required this.status,
    required this.eta,
    required this.requestedAt,
    required this.lastUpdated,
  });

  TransportRequest copyWith({
    String? id,
    String? patientId,
    String? patientName,
    String? pickupLocation,
    String? destinationFacilityId,
    String? destinationName,
    String? transportType,
    String? vehicleInfo,
    String? status,
    String? eta,
    DateTime? requestedAt,
    DateTime? lastUpdated,
  }) {
    return TransportRequest(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      destinationFacilityId:
          destinationFacilityId ?? this.destinationFacilityId,
      destinationName: destinationName ?? this.destinationName,
      transportType: transportType ?? this.transportType,
      vehicleInfo: vehicleInfo ?? this.vehicleInfo,
      status: status ?? this.status,
      eta: eta ?? this.eta,
      requestedAt: requestedAt ?? this.requestedAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
