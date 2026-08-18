import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/mock_data.dart';
import '../../../models/transport_request.dart';
import '../../../theme/colors.dart';
import 'transport_booking_page.dart';
import 'transport_tracking_page.dart';

class TransportPage extends StatefulWidget {
  const TransportPage({super.key});

  @override
  State<TransportPage> createState() => _TransportPageState();
}

class _TransportPageState extends State<TransportPage> {
  final _repo = MockDataRepository.instance();
  TransportRequest? _trackingRequest;
  bool _booking = false;
  TransportRequest? _bookedRequest;

  @override
  Widget build(BuildContext context) {
    if (_booking) {
      return TransportBookingPage(
        onCancel: () => setState(() => _booking = false),
        onBooked: (request) {
          setState(() {
            _booking = false;
            _bookedRequest = request;
          });
        },
      );
    }

    if (_trackingRequest != null) {
      return TransportTrackingPage(
        request: _trackingRequest!,
        onBack: () => setState(() => _trackingRequest = null),
        onStatusChanged: (request) => setState(() => _trackingRequest = request),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: AnimatedBuilder(
        animation: _repo,
        builder: (context, _) {
          final requests = _repo.transportRequests;
          final active = requests
              .where((t) => !['Completed', 'Cancelled'].contains(t.status))
              .toList();
          final history = requests
              .where((t) => ['Completed', 'Cancelled'].contains(t.status))
              .toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(onBook: () => setState(() => _booking = true)),
                const SizedBox(height: 24),
                _SummaryCards(requests: requests),
                if (_bookedRequest != null) ...[
                  const SizedBox(height: 24),
                  _BookedConfirmation(
                    request: _bookedRequest!,
                    onTrack: () => setState(() {
                      _trackingRequest = _bookedRequest;
                      _bookedRequest = null;
                    }),
                  ),
                ],
                const SizedBox(height: 28),
                _SectionTitle(title: 'Active Transport'),
                const SizedBox(height: 12),
                ...active.map(
                  (request) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _TransportCard(
                      request: request,
                      onTrack: () => setState(() => _trackingRequest = request),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _SectionTitle(title: 'Transport History'),
                const SizedBox(height: 12),
                ...history.map((request) => _HistoryCard(request: request)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onBook;

  const _Header({required this.onBook});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 620;
        final title = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Emergency Transport',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.deepNavy,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Coordinate and track transport for patients requiring urgent medical care.',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppColors.secondaryText,
              ),
            ),
          ],
        );
        final button = ElevatedButton.icon(
          onPressed: onBook,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Book Transport'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryTeal,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        );

        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [title, const SizedBox(height: 14), button],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Expanded(child: title), const SizedBox(width: 16), button],
        );
      },
    );
  }
}

class _SummaryCards extends StatelessWidget {
  final List<TransportRequest> requests;

  const _SummaryCards({required this.requests});

  @override
  Widget build(BuildContext context) {
    final cards = [
      ['Active Requests', '2', Icons.pending_actions_rounded, AppColors.mediumRiskOrange],
      ['Booked', '3', Icons.event_available_rounded, AppColors.primaryTeal],
      ['Completed', '8', Icons.check_circle_rounded, AppColors.lowRiskGreen],
      ['Emergency', '1', Icons.emergency_rounded, AppColors.highRiskRed],
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth < 600
            ? (constraints.maxWidth - 12) / 2
            : (constraints.maxWidth - 48) / 4;
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: cards.map((card) {
            final color = card[3] as Color;
            return SizedBox(
              width: width.clamp(150, 260).toDouble(),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(card[2] as IconData, color: color),
                    const SizedBox(height: 12),
                    Text(
                      card[1] as String,
                      style: GoogleFonts.inter(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: AppColors.deepNavy,
                      ),
                    ),
                    Text(
                      card[0] as String,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _BookedConfirmation extends StatelessWidget {
  final TransportRequest request;
  final VoidCallback onTrack;

  const _BookedConfirmation({required this.request, required this.onTrack});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.lightTeal,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryTeal.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transport Booked',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.deepNavy,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 18,
            runSpacing: 8,
            children: [
              _Info('Transport ID', request.id),
              _Info('Patient', request.patientName),
              _Info('Patient ID', request.patientId),
              _Info('Destination', request.destinationName),
              _Info('Status', request.status),
            ],
          ),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: onTrack,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryTeal,
              foregroundColor: AppColors.white,
            ),
            child: const Text('Track Transport'),
          ),
        ],
      ),
    );
  }
}

class _TransportCard extends StatelessWidget {
  final TransportRequest request;
  final VoidCallback onTrack;

  const _TransportCard({required this.request, required this.onTrack});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            runSpacing: 12,
            children: [
              _Info('Patient', request.patientName),
              _Info('Patient ID', request.patientId),
              _Info('Pickup', request.pickupLocation),
              _Info('Destination', request.destinationName),
              _Info('Vehicle', request.transportType),
              _Info('Driver/Vehicle', request.vehicleInfo),
              _Info('Status', request.status),
              _Info('ETA', request.eta),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: onTrack,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryTeal,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Track Transport'),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final TransportRequest request;

  const _HistoryCard({required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Wrap(
        spacing: 18,
        runSpacing: 8,
        children: [
          _Info('Patient', request.patientName),
          _Info('Patient ID', request.patientId),
          _Info('Destination', request.destinationName),
          _Info('Date', _date(request.requestedAt)),
          _Info('Status', request.status),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: AppColors.deepNavy,
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
