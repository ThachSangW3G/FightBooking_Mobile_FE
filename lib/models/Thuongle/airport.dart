class Airport {
  final int id;
  final String airportName;
  final String city;
  final String iataCode;

  Airport({
    required this.id,
    required this.airportName,
    required this.city,
    required this.iataCode,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      id: json['id'] ?? 0,
      airportName: json['airportName'] ?? 'Unknown Airline',
      city: json['city'] ?? '',
      iataCode: json['iataCode'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Airline(id: $id, airportName: $airportName, city: $city, iataCode:$iataCode)';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'airportName': airportName,
      'city': city,
      'iataCode': iataCode,
    };
  }
}
