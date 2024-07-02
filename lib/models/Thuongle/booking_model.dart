// booking_model.dart
import 'package:flightbooking_mobile_fe/models/Thuongle/airline.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/airport.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/flight.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/plane.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/regulation.dart';

class Booking {
  final Flight flight;
  final Airline airline;
  final Plane plane;
  final Regulation regulation;
  final Airport departureAirport;
  final Airport arrivalAirport;
  final List<String> selectedSeats;
  final int? numAdults;
  final int? numChildren;
  final int? numInfants;

  Booking({
    required this.flight,
    required this.airline,
    required this.plane,
    required this.regulation,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.selectedSeats,
    this.numAdults,
    this.numChildren,
    this.numInfants,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      flight: Flight.fromJson(json['flight']),
      airline: Airline.fromJson(json['airline']),
      plane: Plane.fromJson(json['plane']),
      regulation: Regulation.fromJson(json['regulation']),
      departureAirport: Airport.fromJson(json['departureAirport']),
      arrivalAirport: Airport.fromJson(json['arrivalAirport']),
      selectedSeats: List<String>.from(json['selectedSeats']),
      numAdults: json['numAdults'],
      numChildren: json['numChildren'],
      numInfants: json['numInfants'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flight': flight.toJson(),
      'airline': airline.toJson(),
      'plane': plane.toJson(),
      'regulation': regulation.toJson(),
      'departureAirport': departureAirport.toJson(),
      'arrivalAirport': arrivalAirport.toJson(),
      'selectedSeats': selectedSeats,
      'numAdults': numAdults,
      'numChildren': numChildren,
      'numInfants': numInfants,
    };
  }
}
