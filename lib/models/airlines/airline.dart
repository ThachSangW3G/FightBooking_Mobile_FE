import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'airline.g.dart';
part 'airline.freezed.dart';

@freezed
class Airline with _$Airline {
  const factory Airline(
      {required int id,
      required String airlineName,
      required String logoUrl,
      required List<String> picture}) = _Airline;

  factory Airline.fromJson(Map<String, Object?> json) =>
      _$AirlineFromJson(json);
}
