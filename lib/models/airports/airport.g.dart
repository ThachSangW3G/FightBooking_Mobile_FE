// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AirportImpl _$$AirportImplFromJson(Map<String, dynamic> json) =>
    _$AirportImpl(
      id: (json['id'] as num).toInt(),
      airportName: json['airportName'] as String,
      city: json['city'] as String,
      iataCode: json['iataCode'] as String,
    );

Map<String, dynamic> _$$AirportImplToJson(_$AirportImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'airportName': instance.airportName,
      'city': instance.city,
      'iataCode': instance.iataCode,
    };
