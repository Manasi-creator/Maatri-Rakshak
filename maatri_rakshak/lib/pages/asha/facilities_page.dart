import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/mock_data.dart';
import '../../models/facility.dart';
import '../../theme/colors.dart';

class FacilitiesPage extends StatefulWidget {
  const FacilitiesPage({super.key});

  @override
  State<FacilitiesPage> createState() => _FacilitiesPageState();
}

class _FacilitiesPageState extends State<FacilitiesPage> {
  late MockDataRepository _dataRepo;
  late List<Facility> _filteredFacilities;
  final _searchController = TextEditingController();
  String _selectedFilter = 'All';
  String? _selectedFacilityId;

  @override
  void initState() {
    super.initState();
    _dataRepo = MockDataRepository.instance();
    _filteredFacilities = _dataRepo.facilities;
    _selectedFacilityId = _dataRepo.selectedFacility?.id;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    final query = _searchController.text.trim();
    var list = _dataRepo.searchFacilities(query);
    if (_selectedFilter != 'All') {
      list = list.where((f) => f.type == _selectedFilter).toList();
    }
    setState(() {
      _filteredFacilities = list;
    });
  }

  void _filterFacilities(String query) {
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nearby Healthcare Facilities',
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppColors.deepNavy,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Find appropriate healthcare facilities for timely maternal care.',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 24),
          _buildSearchAndFilters(context),
          const SizedBox(height: 24),
          Expanded(child: _buildFacilitiesList()),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters(BuildContext context) {
    final facilitiesTypes = [
      'All',
      'Hospital',
      'Primary Health Centre',
      'Community Health Centre',
      'Maternal Care',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _filterFacilities,
            decoration: InputDecoration(
              hintText: 'Search nearby facilities',
              hintStyle: GoogleFonts.inter(color: AppColors.secondaryText),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColors.primaryText,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: facilitiesTypes.map((type) {
              final isSelected = _selectedFilter == type;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(type),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = type;
                    });
                    _applyFilters();
                  },
                  backgroundColor: AppColors.white,
                  selectedColor: AppColors.primaryTeal,
                  labelStyle: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppColors.white : AppColors.deepNavy,
                  ),
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.primaryTeal
                        : AppColors.border,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFacilitiesList() {
    if (_filteredFacilities.isEmpty) {
      return Center(
        child: Text(
          'No facilities found',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AppColors.secondaryText,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: _filteredFacilities.asMap().entries.map((entry) {
          final facility = entry.value;
          final isLast = entry.key == _filteredFacilities.length - 1;

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(
                    color: _selectedFacilityId == facility.id
                        ? AppColors.primaryTeal
                        : AppColors.border,
                    width: _selectedFacilityId == facility.id ? 2 : 1,
                  ),
                  borderRadius: entry.key == 0 && isLast
                      ? BorderRadius.circular(14)
                      : entry.key == 0
                      ? BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                        )
                      : isLast
                      ? BorderRadius.only(
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(14),
                        )
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                facility.name,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.deepNavy,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.lightTeal,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  facility.type,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryTeal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${facility.distance.toStringAsFixed(1)} km',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.deepNavy,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Away',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      facility.address,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      facility.availability ?? 'Open',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.primaryTeal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () async {
                              if (facility.latitude != null && facility.longitude != null) {
                                final uri = Uri.parse(
                                  'https://www.openstreetmap.org/directions?engine=graphhopper_car&route=;${facility.latitude},${facility.longitude}',
                                );
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                                } else {
                                  final fallbackUri = Uri.parse(
                                    'https://www.google.com/maps/dir/?api=1&destination=${facility.latitude},${facility.longitude}',
                                  );
                                  if (await canLaunchUrl(fallbackUri)) {
                                    await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Could not open map URL.')),
                                    );
                                  }
                                }
                              } else {
                                final addressUri = Uri.parse(
                                  'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(facility.name + ", " + facility.address)}',
                                );
                                if (await canLaunchUrl(addressUri)) {
                                  await launchUrl(addressUri, mode: LaunchMode.externalApplication);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Could not open maps search.')),
                                  );
                                }
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primaryTeal,
                              side: BorderSide(color: AppColors.primaryTeal),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Get Directions',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (_selectedFacilityId == facility.id) {
                                  _selectedFacilityId = null;
                                  _dataRepo.selectedFacility = null;
                                } else {
                                  _selectedFacilityId = facility.id;
                                  _dataRepo.selectedFacility = facility;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Selected facility: ${facility.name}'),
                                      backgroundColor: AppColors.lowRiskGreen,
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedFacilityId == facility.id
                                  ? AppColors.deepNavy
                                  : AppColors.primaryTeal,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              _selectedFacilityId == facility.id ? 'Selected' : 'Select',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
