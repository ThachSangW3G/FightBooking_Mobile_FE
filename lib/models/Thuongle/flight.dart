class Flight {
  final String flightStatus;
  final int departureDate;
  final int arrivalDate;
  final int duration;
  final int departureAirportId;
  final int arrivalAirportId;
  final int planeId;

  Flight({
    required this.flightStatus,
    required this.departureDate,
    required this.arrivalDate,
    required this.duration,
    required this.departureAirportId,
    required this.arrivalAirportId,
    required this.planeId,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      flightStatus: json['flightStatus'] ?? 'UNKNOWN',
      departureDate: json['departureDate'] ?? 0,
      arrivalDate: json['arrivalDate'] ?? 0,
      duration: json['duration'] ?? 0,
      departureAirportId: json['departureAirportId'] ?? 0,
      arrivalAirportId: json['arrivalAirportId'] ?? 0,
      planeId: json['planeId'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Flight(flightStatus: $flightStatus, departureDate: $departureDate, arrivalDate: $arrivalDate, duration: $duration, departureAirportId: $departureAirportId, arrivalAirportId: $arrivalAirportId, planeId: $planeId)';
  }
}
