// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AirlineImpl _$$AirlineImplFromJson(Map<String, dynamic> json) =>
    _$AirlineImpl(
      id: (json['id'] as num).toInt(),
      airlineName: json['airlineName'] as String,
      logoUrl: json['logoUrl'] as String,
      picture:
          (json['picture'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$AirlineImplToJson(_$AirlineImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'airlineName': instance.airlineName,
      'logoUrl': instance.logoUrl,
      'picture': instance.picture,
    };
