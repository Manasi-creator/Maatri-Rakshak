class Facility {
  final String id;
  final String name;
  final String
  type; // Hospital, Primary Health Centre, Community Health Centre, Maternal Care
  final String address;
  final double distance; // in km
  final List<String> services;
  final String? availability;
  final String? phone;
  final double? latitude;
  final double? longitude;

  Facility({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.distance,
    required this.services,
    this.availability,
    this.phone,
    this.latitude,
    this.longitude,
  });

  Facility copyWith({
    String? id,
    String? name,
    String? type,
    String? address,
    double? distance,
    List<String>? services,
    String? availability,
    String? phone,
    double? latitude,
    double? longitude,
  }) {
    return Facility(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      distance: distance ?? this.distance,
      services: services ?? this.services,
      availability: availability ?? this.availability,
      phone: phone ?? this.phone,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
