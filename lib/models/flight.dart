class Flight {
  final int id;
  final String flightStatus;
  final DateTime departureDate;
  final DateTime arrivalDate;
  final int duration;
  final int departureAirportId;
  final int arrivalAirportId;
  final int planeId;
  final double economyPrice;
  final double businessPrice;
  final double firstClassPrice;
  final String seatStatuses;

  Flight(
      {required this.id,
      required this.flightStatus,
      required this.departureDate,
      required this.arrivalDate,
      required this.duration,
      required this.departureAirportId,
      required this.arrivalAirportId,
      required this.planeId,
      required this.economyPrice,
      required this.businessPrice,
      required this.firstClassPrice,
      required this.seatStatuses});

  factory Flight.fromJson(Map<String, dynamic> json) {
    DateTime departureDateTime =
        DateTime.fromMillisecondsSinceEpoch(json['departureDate']);
    DateTime arrivalDateTime =
        DateTime.fromMillisecondsSinceEpoch(json['arrivalDate']);
    return Flight(
      id: json['id'],
      flightStatus: json['flightStatus'],
      departureDate: departureDateTime,
      arrivalDate: arrivalDateTime,
      duration: json['duration'],
      departureAirportId: json['departureAirportId'],
      arrivalAirportId: json['arrivalAirportId'],
      planeId: json['planeId'],
      economyPrice: json['economyPrice'],
      businessPrice: json['businessPrice'],
      firstClassPrice: json['firstClassPrice'],
      seatStatuses: json['seatStatuses'],
    );
  }
}
