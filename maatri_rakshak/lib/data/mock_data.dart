import 'package:flutter/foundation.dart';
import '../models/patient.dart';
import '../models/assessment.dart';
import '../models/facility.dart';
import '../models/report_record.dart';
import '../models/timeline_event.dart';
import '../models/transport_request.dart';

class MockDataRepository extends ChangeNotifier {
  late List<Patient> _patients;
  late List<Assessment> _assessments;
  late final List<Facility> _facilities;
  late List<TransportRequest> _transportRequests;
  late List<ReportRecord> _reports;
  late List<TimelineEvent> _timelineEvents;

  MockDataRepository() {
    _initializeData();
  }

  void _initializeData() {
    // Initialize mock patients (alphabetically sorted)
    _patients = [
      Patient(
        id: '10234',
        name: 'Asha Patil',
        age: 24,
        pregnancyWeek: 28,
        bloodGroup: 'O+',
        address: 'Shivaji Nagar, Pune',
        phone: '9876543210',
        lastAssessment: DateTime.now(),
        riskLevel: 'Stable',
        riskScore: 42,
        expectedDeliveryDate: DateTime.now().add(const Duration(days: 84)),
        previousPregnancies: 0,
        currentVitals: {
          'bloodPressure': '120/80',
          'haemoglobin': '11.5',
          'temperature': '98.6',
          'pulse': '72',
        },
      ),
      Patient(
        id: '10482',
        name: 'Kavita More',
        age: 27,
        pregnancyWeek: 32,
        bloodGroup: 'B+',
        address: 'Viman Nagar, Pune',
        phone: '9876543211',
        lastAssessment: DateTime.now().subtract(const Duration(days: 1)),
        riskLevel: 'Needs Review',
        riskScore: 65,
        expectedDeliveryDate: DateTime.now().add(const Duration(days: 56)),
        previousPregnancies: 1,
        previousComplications: ['Gestational diabetes'],
        currentVitals: {
          'bloodPressure': '135/88',
          'haemoglobin': '10.5',
          'temperature': '98.8',
          'pulse': '78',
        },
      ),
      Patient(
        id: '10831',
        name: 'Meena Shinde',
        age: 23,
        pregnancyWeek: 24,
        bloodGroup: 'A+',
        address: 'Koregaon Park, Pune',
        phone: '9876543212',
        lastAssessment: DateTime.now(),
        riskLevel: 'Stable',
        riskScore: 38,
        expectedDeliveryDate: DateTime.now().add(const Duration(days: 112)),
        previousPregnancies: 0,
        currentVitals: {
          'bloodPressure': '118/76',
          'haemoglobin': '12.0',
          'temperature': '98.4',
          'pulse': '70',
        },
      ),
      Patient(
        id: '10567',
        name: 'Priya Desai',
        age: 29,
        pregnancyWeek: 30,
        bloodGroup: 'O-',
        address: 'Aundh, Pune',
        phone: '9876543213',
        lastAssessment: DateTime.now().subtract(const Duration(days: 2)),
        riskLevel: 'High',
        riskScore: 78,
        expectedDeliveryDate: DateTime.now().add(const Duration(days: 70)),
        previousPregnancies: 1,
        previousComplications: ['Preeclampsia in previous pregnancy'],
        medicalConditions: ['Hypertension'],
        currentVitals: {
          'bloodPressure': '145/92',
          'haemoglobin': '10.2',
          'temperature': '99.1',
          'pulse': '82',
        },
      ),
      Patient(
        id: '10765',
        name: 'Sunita More',
        age: 25,
        pregnancyWeek: 35,
        bloodGroup: 'AB+',
        address: 'Baner, Pune',
        phone: '9876543214',
        lastAssessment: DateTime.now(),
        riskLevel: 'Emergency',
        riskScore: 91,
        expectedDeliveryDate: DateTime.now().add(const Duration(days: 35)),
        previousPregnancies: 2,
        previousComplications: ['Premature labor', 'Placental complications'],
        medicalConditions: ['Diabetes mellitus'],
        currentVitals: {
          'bloodPressure': '155/100',
          'haemoglobin': '9.8',
          'temperature': '99.5',
          'pulse': '88',
        },
      ),
    ];

    // Initialize mock assessments
    _assessments = [
      Assessment(
        id: 'A001',
        patientId: '10234',
        patientName: 'Asha Patil',
        date: DateTime.now(),
        riskScore: 42,
        urgency: 'Routine',
        status: 'Completed',
        symptoms: [],
        vitals: {
          'bloodPressure': '120/80',
          'haemoglobin': '11.5',
          'temperature': '98.6',
          'pulse': '72',
        },
        dangerSigns: [],
        explanation: 'Patient is stable with normal vitals.',
      ),
      Assessment(
        id: 'A002',
        patientId: '10482',
        patientName: 'Kavita More',
        date: DateTime.now().subtract(const Duration(days: 1)),
        riskScore: 65,
        urgency: 'Medical Review',
        status: 'Completed',
        symptoms: ['Swelling', 'Headache'],
        vitals: {
          'bloodPressure': '135/88',
          'haemoglobin': '10.5',
          'temperature': '98.8',
          'pulse': '78',
        },
        dangerSigns: ['Elevated blood pressure', 'Low haemoglobin'],
        explanation:
            'Elevated BP and history of gestational diabetes require medical review.',
      ),
      Assessment(
        id: 'A003',
        patientId: '10567',
        patientName: 'Priya Desai',
        date: DateTime.now().subtract(const Duration(days: 2)),
        riskScore: 78,
        urgency: 'High Priority',
        status: 'Pending Review',
        symptoms: ['Severe headache', 'Blurred vision', 'Swelling'],
        vitals: {
          'bloodPressure': '145/92',
          'haemoglobin': '10.2',
          'temperature': '99.1',
          'pulse': '82',
        },
        dangerSigns: [
          'Very high blood pressure',
          'Vision changes',
          'Severe edema',
        ],
        explanation:
            'Symptoms suggest possible preeclampsia. Immediate medical evaluation recommended.',
      ),
    ];

    // Initialize mock facilities
    _facilities = [
      Facility(
        id: 'F001',
        name: 'District Women\'s Hospital',
        type: 'Hospital',
        address: 'Shivaji Nagar, Pune',
        distance: 2.4,
        services: [
          'Maternal Emergency',
          'Delivery',
          'Obstetric Care',
          'Emergency Care',
        ],
        availability: 'Maternal care available',
        phone: '9876543220',
        latitude: 18.5204,
        longitude: 73.8567,
      ),
      Facility(
        id: 'F002',
        name: 'Aundh Primary Health Centre',
        type: 'Primary Health Centre',
        address: 'Aundh, Pune',
        distance: 1.8,
        services: ['Prenatal Care', 'Basic Emergency', 'Referral Support'],
        availability: '24/7 available',
        phone: '9876543221',
        latitude: 18.5534,
        longitude: 73.8102,
      ),
      Facility(
        id: 'F003',
        name: 'Viman Nagar Community Health Centre',
        type: 'Community Health Centre',
        address: 'Viman Nagar, Pune',
        distance: 3.2,
        services: ['Maternal Health', 'Immunization', 'Basic Delivery'],
        availability: '8 AM - 6 PM',
        phone: '9876543222',
        latitude: 18.5621,
        longitude: 73.8945,
      ),
      Facility(
        id: 'F004',
        name: 'Koregaon Park Maternal Care',
        type: 'Maternal Care',
        address: 'Koregaon Park, Pune',
        distance: 2.1,
        services: ['Prenatal Care', 'Labor Support', 'Postnatal Care'],
        availability: 'Maternal care available',
        phone: '9876543223',
        latitude: 18.5301,
        longitude: 73.8834,
      ),
      Facility(
        id: 'F005',
        name: 'Baner Health Post',
        type: 'Primary Health Centre',
        address: 'Baner, Pune',
        distance: 4.5,
        services: ['Health Education', 'Referral Services'],
        availability: '10 AM - 4 PM (Weekdays)',
        phone: '9876543224',
        latitude: 18.5678,
        longitude: 73.8123,
      ),
    ];

    final now = DateTime.now();

    _transportRequests = [
      TransportRequest(
        id: 'TR-2026-001',
        patientId: '10234',
        patientName: 'Asha Patil',
        pickupLocation: 'Shivaji Nagar, Pune',
        destinationFacilityId: 'F001',
        destinationName: 'District Women\'s Hospital',
        transportType: 'Emergency Ambulance',
        vehicleInfo: 'MH 12 AB 2045 - Driver: Ramesh',
        status: 'En Route',
        eta: '8 minutes',
        requestedAt: DateTime(now.year, now.month, now.day, 10, 52),
        lastUpdated: DateTime(now.year, now.month, now.day, 10, 42),
      ),
      TransportRequest(
        id: 'TR-2026-002',
        patientId: '10765',
        patientName: 'Sunita More',
        pickupLocation: 'Baner, Pune',
        destinationFacilityId: 'F001',
        destinationName: 'District Women\'s Hospital',
        transportType: 'Emergency Ambulance',
        vehicleInfo: 'MH 12 CD 7710 - Driver: Imran',
        status: 'Driver Assigned',
        eta: '14 minutes',
        requestedAt: DateTime(now.year, now.month, now.day, 9, 35),
        lastUpdated: DateTime(now.year, now.month, now.day, 9, 48),
      ),
      TransportRequest(
        id: 'TR-2026-003',
        patientId: '10482',
        patientName: 'Kavita More',
        pickupLocation: 'Viman Nagar, Pune',
        destinationFacilityId: 'F003',
        destinationName: 'Viman Nagar Community Health Centre',
        transportType: 'Standard Ambulance',
        vehicleInfo: 'Community ambulance',
        status: 'Completed',
        eta: 'Completed',
        requestedAt: now.subtract(const Duration(days: 1, hours: 3)),
        lastUpdated: now.subtract(const Duration(days: 1, hours: 2)),
      ),
    ];

    _reports = [
      ReportRecord(
        id: 'DR-001',
        type: 'Doctor Review',
        patientId: '10234',
        patientName: 'Asha Patil',
        createdAt: DateTime(now.year, now.month, now.day, 11, 40),
        createdBy: 'ASHA Worker',
        status: 'Available',
        doctorName: 'Dr. Priya Sharma',
        hospitalName: 'District Women\'s Hospital',
        hospitalAddress: 'Shivaji Nagar, Pune',
        observations:
            'Patient reviewed for elevated risk signs after referral.',
        clinicalImpression: 'Requires observation and follow-up vitals.',
        recommendedActions:
            'Continue monitoring, repeat BP, and follow approved protocol.',
        followUpDate: now.add(const Duration(days: 7)),
        notes: 'Information entered by ASHA worker after consultation.',
      ),
      ReportRecord(
        id: 'CS-001',
        type: 'Case Summary',
        patientId: '10234',
        patientName: 'Asha Patil',
        createdAt: DateTime(now.year, now.month, now.day, 10, 35),
        createdBy: 'ASHA Worker',
        status: 'Available',
      ),
      ReportRecord(
        id: 'CS-002',
        type: 'Case Summary',
        patientId: '10482',
        patientName: 'Kavita More',
        createdAt: now.subtract(const Duration(days: 1, hours: 2)),
        createdBy: 'ASHA Worker',
        status: 'Available',
      ),
    ];

    _timelineEvents = [
      TimelineEvent(
        id: 'TL-001',
        patientId: '10234',
        patientName: 'Asha Patil',
        eventType: 'Doctor Review Added',
        timestamp: DateTime(now.year, now.month, now.day, 11, 40),
      ),
      TimelineEvent(
        id: 'TL-002',
        patientId: '10234',
        patientName: 'Asha Patil',
        eventType: 'Transport Booked',
        timestamp: DateTime(now.year, now.month, now.day, 10, 52),
      ),
      TimelineEvent(
        id: 'TL-003',
        patientId: '10234',
        patientName: 'Asha Patil',
        eventType: 'Case Summary Created',
        timestamp: DateTime(now.year, now.month, now.day, 10, 35),
      ),
      TimelineEvent(
        id: 'TL-004',
        patientId: '10234',
        patientName: 'Asha Patil',
        eventType: 'Updated Vitals',
        timestamp: DateTime(now.year, now.month, now.day, 10, 30),
      ),
      TimelineEvent(
        id: 'TL-005',
        patientId: '10482',
        patientName: 'Kavita More',
        eventType: 'Assessment Completed',
        timestamp: now.subtract(const Duration(days: 1, hours: 3)),
      ),
      TimelineEvent(
        id: 'TL-006',
        patientId: '10482',
        patientName: 'Kavita More',
        eventType: 'Case Summary Created',
        timestamp: now.subtract(const Duration(days: 1, hours: 2)),
      ),
    ]..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Patient? _selectedPatient;
  Facility? _selectedFacility;

  Patient? get selectedPatient => _selectedPatient;
  set selectedPatient(Patient? patient) {
    _selectedPatient = patient;
    notifyListeners();
  }

  Facility? get selectedFacility => _selectedFacility;
  set selectedFacility(Facility? facility) {
    _selectedFacility = facility;
    notifyListeners();
  }

  List<Patient> get patients => _patients;
  List<Assessment> get assessments => _assessments;
  List<Facility> get facilities => _facilities;
  List<TransportRequest> get transportRequests => _transportRequests;
  List<ReportRecord> get reports =>
      [..._reports]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  List<TimelineEvent> get timelineEvents =>
      [..._timelineEvents]..sort((a, b) => b.timestamp.compareTo(a.timestamp));

  Patient? getPatient(String id) {
    try {
      return _patients.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void addPatient(Patient patient) {
    _patients.add(patient);
    // Keep list sorted by name
    _patients.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void updatePatient(Patient patient) {
    final index = _patients.indexWhere((p) => p.id == patient.id);
    if (index >= 0) {
      _patients[index] = patient;
      _patients.sort((a, b) => a.name.compareTo(b.name));
      notifyListeners();
    }
  }

  void addAssessment(Assessment assessment) {
    _assessments.add(assessment);
    _assessments.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  List<Patient> searchPatients(String query) {
    if (query.isEmpty) return _patients;
    final lowerQuery = query.toLowerCase();
    return _patients
        .where(
          (p) =>
              p.name.toLowerCase().contains(lowerQuery) || p.id.contains(query),
        )
        .toList();
  }

  List<Facility> searchFacilities(String query) {
    if (query.isEmpty) return _facilities;
    final lowerQuery = query.toLowerCase();
    return _facilities
        .where(
          (f) =>
              f.name.toLowerCase().contains(lowerQuery) ||
              f.type.toLowerCase().contains(lowerQuery) ||
              f.address.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  List<Assessment> getPatientAssessments(String patientId) {
    return _assessments.where((a) => a.patientId == patientId).toList();
  }

  Assessment? getLatestAssessment(String patientId) {
    final patientAssessments = getPatientAssessments(patientId)
      ..sort((a, b) => b.date.compareTo(a.date));
    return patientAssessments.isEmpty ? null : patientAssessments.first;
  }

  void addTransportRequest(TransportRequest request) {
    _transportRequests.add(request);
    addTimelineEvent(
      TimelineEvent(
        id: 'TL-${DateTime.now().millisecondsSinceEpoch}',
        patientId: request.patientId,
        patientName: request.patientName,
        eventType: 'Transport Booked',
        timestamp: DateTime.now(),
      ),
      notify: false,
    );
    notifyListeners();
  }

  void updateTransportStatus(String transportId, String status) {
    final index = _transportRequests.indexWhere((t) => t.id == transportId);
    if (index >= 0) {
      final updated = _transportRequests[index].copyWith(
        status: status,
        lastUpdated: DateTime.now(),
      );
      _transportRequests[index] = updated;
      addTimelineEvent(
        TimelineEvent(
          id: 'TL-${DateTime.now().millisecondsSinceEpoch}',
          patientId: updated.patientId,
          patientName: updated.patientName,
          eventType: 'Transport Status Updated',
          timestamp: DateTime.now(),
        ),
        notify: false,
      );
      notifyListeners();
    }
  }

  void addReport(ReportRecord report) {
    _reports.add(report);
    addTimelineEvent(
      TimelineEvent(
        id: 'TL-${DateTime.now().millisecondsSinceEpoch}',
        patientId: report.patientId,
        patientName: report.patientName,
        eventType: report.type == 'Doctor Review'
            ? 'Doctor Review Added'
            : 'Case Summary Created',
        timestamp: report.createdAt,
      ),
      notify: false,
    );
    notifyListeners();
  }

  void addTimelineEvent(TimelineEvent event, {bool notify = true}) {
    _timelineEvents.add(event);
    _timelineEvents.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    if (notify) notifyListeners();
  }

  static final MockDataRepository _instance = MockDataRepository._();

  factory MockDataRepository.instance() {
    return _instance;
  }

  MockDataRepository._() {
    _initializeData();
  }
}
