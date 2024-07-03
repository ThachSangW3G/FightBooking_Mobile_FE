class Airline {
  final int id;
  final String airlineName;
  final String logoUrl;

  Airline({
    required this.id,
    required this.airlineName,
    required this.logoUrl,
  });

  factory Airline.fromJson(Map<String, dynamic> json) {
    return Airline(
      id: json['id'] ?? 0,
      airlineName: json['airlineName'] ?? 'Unknown Airline',
      logoUrl: json['logoUrl'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Airline(id: $id, airlineName: $airlineName, logoUrl: $logoUrl)';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'airlineName': airlineName,
      'logoUrl': logoUrl,
    };
  }
}
