import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/mock_data.dart';
import '../../../models/transport_request.dart';
import '../../../theme/colors.dart';

class TransportTrackingPage extends StatelessWidget {
  final TransportRequest request;
  final VoidCallback onBack;
  final ValueChanged<TransportRequest> onStatusChanged;

  const TransportTrackingPage({
    super.key,
    required this.request,
    required this.onBack,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final statuses = [
      'Booked',
      'Driver Assigned',
      'En Route',
      'Arriving',
      'Arrived',
      'Completed',
    ];
    final currentIndex = statuses.indexOf(request.status).clamp(0, statuses.length - 1);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Back to Transport'),
            ),
            const SizedBox(height: 8),
            Text(
              'Track Transport',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.deepNavy,
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 18,
                    runSpacing: 10,
                    children: [
                      _Info('Patient', request.patientName),
                      _Info('Patient ID', request.patientId),
                      _Info('Transport ID', request.id),
                      _Info('Destination', request.destinationName),
                      _Info('Vehicle information', request.vehicleInfo),
                      _Info('ETA', request.eta),
                      _Info('Last Updated', _time(request.lastUpdated)),
                    ],
                  ),
                  const SizedBox(height: 26),
                  ...statuses.asMap().entries.map((entry) {
                    final index = entry.key;
                    final status = entry.value;
                    final done = index < currentIndex;
                    final active = index == currentIndex;
                    final color = done || active
                        ? AppColors.primaryTeal
                        : AppColors.border;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Icon(
                              done
                                  ? Icons.check_circle_rounded
                                  : active
                                  ? Icons.radio_button_checked_rounded
                                  : Icons.radio_button_unchecked_rounded,
                              color: color,
                            ),
                            if (index != statuses.length - 1)
                              Container(
                                width: 2,
                                height: 28,
                                color: color.withValues(alpha: 0.55),
                              ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            status,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight:
                                  active ? FontWeight.w800 : FontWeight.w600,
                              color: active
                                  ? AppColors.deepNavy
                                  : AppColors.secondaryText,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: statuses.map((status) {
                      return OutlinedButton(
                        onPressed: () {
                          final repo = MockDataRepository.instance();
                          repo.updateTransportStatus(request.id, status);
                          final updated = repo.transportRequests.firstWhere(
                            (item) => item.id == request.id,
                          );
                          onStatusChanged(updated);
                        },
                        child: Text(status),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
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
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 12, color: AppColors.secondaryText),
          ),
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

String _time(DateTime value) {
  final hour = value.hour > 12 ? value.hour - 12 : value.hour;
  final displayHour = hour == 0 ? 12 : hour;
  final minute = value.minute.toString().padLeft(2, '0');
  final suffix = value.hour >= 12 ? 'PM' : 'AM';
  return '$displayHour:$minute $suffix';
}
