// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FlightImpl _$$FlightImplFromJson(Map<String, dynamic> json) => _$FlightImpl(
      id: (json['id'] as num).toInt(),
      flightStatus: json['flightStatus'] as String,
      departureDate: DateTime.parse(json['departureDate'] as String),
      arrivalDate: DateTime.parse(json['arrivalDate'] as String),
      departureAirportId: (json['departureAirportId'] as num).toInt(),
      arrivalAirportId: (json['arrivalAirportId'] as num).toInt(),
      planeId: (json['planeId'] as num).toInt(),
      economyPrice: (json['economyPrice'] as num).toDouble(),
      businessPrice: (json['businessPrice'] as num).toDouble(),
      firstClassPrice: (json['firstClassPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$$FlightImplToJson(_$FlightImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'flightStatus': instance.flightStatus,
      'departureDate': instance.departureDate.toIso8601String(),
      'arrivalDate': instance.arrivalDate.toIso8601String(),
      'departureAirportId': instance.departureAirportId,
      'arrivalAirportId': instance.arrivalAirportId,
      'planeId': instance.planeId,
      'economyPrice': instance.economyPrice,
      'businessPrice': instance.businessPrice,
      'firstClassPrice': instance.firstClassPrice,
    };
