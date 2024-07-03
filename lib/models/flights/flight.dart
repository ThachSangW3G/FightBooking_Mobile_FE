import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'flight.g.dart';
part 'flight.freezed.dart';

@freezed
class Flight with _$Flight {
  const factory Flight(
      {required int id,
      required String flightStatus,
      required DateTime departureDate,
      required DateTime arrivalDate,
      required int departureAirportId,
      required int arrivalAirportId,
      required int planeId,
      required double economyPrice,
      required double businessPrice,
      required double firstClassPrice,
      required int duration,
      required int airlineId,
      required String airlineName}) = _Flight;

  factory Flight.fromJson(Map<String, Object?> json) => _$FlightFromJson(json);
}
