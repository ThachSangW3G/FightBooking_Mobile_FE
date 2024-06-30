import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'airport.g.dart';
part 'airport.freezed.dart';

@freezed
class Airport with _$Airport {
  const factory Airport(
      {required int id,
      required String airportName,
      required String city,
      required String iataCode}) = _Airport;

  factory Airport.fromJson(Map<String, Object?> json) =>
      _$AirportFromJson(json);
}
