import 'package:intl/intl.dart';

class Ticket {
  final String airlineLogo;
  final String departAirport;
  final String arrivalAirport;
  final DateTime departDate;
  final DateTime arrivalDate;
  final String iataCodeDepart;
  final String iataCodeArrival;
  final List<String> seatNumber;
  final int bookingId;

  Ticket({
    required this.airlineLogo,
    required this.departAirport,
    required this.arrivalAirport,
    required this.departDate,
    required this.arrivalDate,
    required this.iataCodeDepart,
    required this.iataCodeArrival,
    required this.seatNumber,
    required this.bookingId,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      airlineLogo: json['airlineLogo'],
      departAirport: json['departAirport'],
      arrivalAirport: json['arrivalAirport'],
      departDate: DateTime.fromMillisecondsSinceEpoch(json['departDate']),
      arrivalDate: DateTime.fromMillisecondsSinceEpoch(json['arrivalDate']),
      iataCodeDepart: json['iataCodeDepart'],
      iataCodeArrival: json['iataCodeArrival'],
      seatNumber: List<String>.from(json['seatNumber']),
      bookingId: json['bookingId'],
    );
  }
  String get formattedDepartDate {
    return DateFormat('HH:mm').format(departDate);
  }

  String get formattedArrivalDate {
    return DateFormat('HH:mm').format(arrivalDate);
  }

  String get formattedDepartDateWithDay {
    return DateFormat('EEE, dd/MM/yyyy').format(departDate);
  }

  String get formattedArrivalDateWithDay {
    return DateFormat('EEE, dd/MM/yyyy').format(arrivalDate);
  }
}
