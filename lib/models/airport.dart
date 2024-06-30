class Airport {
  final int id;
  final String airportName;
  final String city;
  final String iataCode;

  Airport(
      {required this.id,
      required this.airportName,
      required this.city,
      required this.iataCode});

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      id: json['id'],
      airportName: json['airportName'],
      city: json['city'],
      iataCode: json['iataCode'],
    );
  }
}
