class Agency {
  final String agencyId;
  final String name;
  final String city;
  Agency({
    required this.agencyId,
    required this.name,
    required this.city,
  });

  factory Agency.fromMap(Map<String, dynamic> map) {
    return Agency(
      agencyId: map['agencyId'] ?? '',
      name: map['name'] ?? '',
      city: map['city'] ?? '',
    );
  }
  @override
  String toString() {
    return 'Agency(agency: $name, agencyId: $agencyId, agencyCity: $city)';
  }
}
