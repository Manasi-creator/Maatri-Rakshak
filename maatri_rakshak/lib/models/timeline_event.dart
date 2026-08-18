class TimelineEvent {
  final String id;
  final String patientId;
  final String patientName;
  final String eventType;
  final DateTime timestamp;

  TimelineEvent({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.eventType,
    required this.timestamp,
  });
}
