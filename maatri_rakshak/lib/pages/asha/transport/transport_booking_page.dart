import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/mock_data.dart';
import '../../../models/facility.dart';
import '../../../models/patient.dart';
import '../../../models/transport_request.dart';
import '../../../theme/colors.dart';

class TransportBookingPage extends StatefulWidget {
  final VoidCallback onCancel;
  final ValueChanged<TransportRequest> onBooked;

  const TransportBookingPage({
    super.key,
    required this.onCancel,
    required this.onBooked,
  });

  @override
  State<TransportBookingPage> createState() => _TransportBookingPageState();
}

class _TransportBookingPageState extends State<TransportBookingPage> {
  final _repo = MockDataRepository.instance();
  final _searchController = TextEditingController();
  final _addressController = TextEditingController(text: 'Shivaji Nagar, Pune');
  int _step = 0;
  Patient? _patient;
  Facility? _facility;
  String _transportType = 'Emergency Ambulance';
  List<Patient> _patients = [];

  @override
  void initState() {
    super.initState();
    _patients = _repo.patients;
    _patient = _repo.patients.first;
    _facility = _repo.facilities.first;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _book() {
    final patient = _patient!;
    final facility = _facility!;
    final request = TransportRequest(
      id: 'TR-2026-${(_repo.transportRequests.length + 1).toString().padLeft(3, '0')}',
      patientId: patient.id,
      patientName: patient.name,
      pickupLocation: _addressController.text.trim().isEmpty
          ? patient.address
          : _addressController.text.trim(),
      destinationFacilityId: facility.id,
      destinationName: facility.name,
      transportType: _transportType,
      vehicleInfo: 'Driver assignment pending',
      status: 'Booked',
      eta: '12 minutes',
      requestedAt: DateTime.now(),
      lastUpdated: DateTime.now(),
    );
    _repo.addTransportRequest(request);
    widget.onBooked(request);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: widget.onCancel,
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Back to Transport'),
            ),
            const SizedBox(height: 8),
            Text(
              'Book Transport',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.deepNavy,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Select a patient, pickup location, facility, and transport type.',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 22),
            Stepper(
              currentStep: _step,
              onStepTapped: (step) => setState(() => _step = step),
              controlsBuilder: (context, details) {
                final isLast = _step == 4;
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ElevatedButton(
                        onPressed: isLast
                            ? _book
                            : () => setState(() => _step += 1),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryTeal,
                          foregroundColor: AppColors.white,
                        ),
                        child: Text(isLast ? 'Confirm Transport' : 'Continue'),
                      ),
                      if (_step > 0)
                        OutlinedButton(
                          onPressed: () => setState(() => _step -= 1),
                          child: const Text('Back'),
                        ),
                    ],
                  ),
                );
              },
              steps: [
                Step(
                  title: const Text('Select Patient'),
                  isActive: _step >= 0,
                  content: _PatientSelector(
                    patients: _patients,
                    selected: _patient,
                    searchController: _searchController,
                    onSearch: (query) =>
                        setState(() => _patients = _repo.searchPatients(query)),
                    onSelected: (patient) => setState(() {
                      _patient = patient;
                      _addressController.text = patient.address;
                    }),
                  ),
                ),
                Step(
                  title: const Text('Pickup Location'),
                  isActive: _step >= 1,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'Manual Address',
                          hintText: 'Current location or pickup address',
                        ),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton.icon(
                        onPressed: () => setState(() {
                          _addressController.text =
                              _patient?.address ?? 'Current ASHA location';
                        }),
                        icon: const Icon(Icons.my_location_rounded),
                        label: const Text('Use Current Location'),
                      ),
                    ],
                  ),
                ),
                Step(
                  title: const Text('Select Facility'),
                  isActive: _step >= 2,
                  content: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _repo.facilities
                        .map(
                          (facility) => _ChoiceCard(
                            title: facility.name,
                            subtitle:
                                '${facility.type} - ${facility.distance.toStringAsFixed(1)} km',
                            selected: _facility?.id == facility.id,
                            onTap: () => setState(() => _facility = facility),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Step(
                  title: const Text('Transport Type'),
                  isActive: _step >= 3,
                  content: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      'Emergency Ambulance',
                      'Standard Ambulance',
                      'Community Transport',
                    ]
                        .map(
                          (type) => _ChoiceCard(
                            title: type,
                            subtitle: 'Mock dispatch option',
                            selected: _transportType == type,
                            onTap: () => setState(() => _transportType = type),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Step(
                  title: const Text('Confirm Booking'),
                  isActive: _step >= 4,
                  content: _ConfirmCard(
                    patient: _patient!,
                    pickup: _addressController.text,
                    facility: _facility!,
                    transportType: _transportType,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientSelector extends StatelessWidget {
  final List<Patient> patients;
  final Patient? selected;
  final TextEditingController searchController;
  final ValueChanged<String> onSearch;
  final ValueChanged<Patient> onSelected;

  const _PatientSelector({
    required this.patients,
    required this.selected,
    required this.searchController,
    required this.onSearch,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: searchController,
          onChanged: onSearch,
          decoration: const InputDecoration(
            hintText: 'Search patient by name or patient ID',
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: patients
              .map(
                (patient) => _ChoiceCard(
                  title: patient.name,
                  subtitle:
                      'Patient ID: ${patient.id} - ${patient.riskLevel} - ${_urgency(patient)}',
                  selected: selected?.id == patient.id,
                  onTap: () => onSelected(patient),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  static String _urgency(Patient patient) {
    if (patient.riskLevel == 'Emergency') return 'Immediate Attention';
    if (patient.riskLevel == 'High') return 'High Priority';
    if (patient.riskLevel == 'Needs Review') return 'Medical Review';
    return 'Routine';
  }
}

class _ChoiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _ChoiceCard({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected ? AppColors.lightTeal : AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? AppColors.primaryTeal : AppColors.border,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.deepNavy,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfirmCard extends StatelessWidget {
  final Patient patient;
  final String pickup;
  final Facility facility;
  final String transportType;

  const _ConfirmCard({
    required this.patient,
    required this.pickup,
    required this.facility,
    required this.transportType,
  });

  @override
  Widget build(BuildContext context) {
    final rows = {
      'Patient': '${patient.name} (${patient.id})',
      'Pickup': pickup,
      'Destination': facility.name,
      'Transport type': transportType,
    };
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows.entries
            .map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  '${entry.key}: ${entry.value}',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.deepNavy,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
