// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'airport.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Airport _$AirportFromJson(Map<String, dynamic> json) {
  return _Airport.fromJson(json);
}

/// @nodoc
mixin _$Airport {
  int get id => throw _privateConstructorUsedError;
  String get airportName => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get iataCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AirportCopyWith<Airport> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AirportCopyWith<$Res> {
  factory $AirportCopyWith(Airport value, $Res Function(Airport) then) =
      _$AirportCopyWithImpl<$Res, Airport>;
  @useResult
  $Res call({int id, String airportName, String city, String iataCode});
}

/// @nodoc
class _$AirportCopyWithImpl<$Res, $Val extends Airport>
    implements $AirportCopyWith<$Res> {
  _$AirportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? airportName = null,
    Object? city = null,
    Object? iataCode = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      airportName: null == airportName
          ? _value.airportName
          : airportName // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      iataCode: null == iataCode
          ? _value.iataCode
          : iataCode // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AirportImplCopyWith<$Res> implements $AirportCopyWith<$Res> {
  factory _$$AirportImplCopyWith(
          _$AirportImpl value, $Res Function(_$AirportImpl) then) =
      __$$AirportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String airportName, String city, String iataCode});
}

/// @nodoc
class __$$AirportImplCopyWithImpl<$Res>
    extends _$AirportCopyWithImpl<$Res, _$AirportImpl>
    implements _$$AirportImplCopyWith<$Res> {
  __$$AirportImplCopyWithImpl(
      _$AirportImpl _value, $Res Function(_$AirportImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? airportName = null,
    Object? city = null,
    Object? iataCode = null,
  }) {
    return _then(_$AirportImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      airportName: null == airportName
          ? _value.airportName
          : airportName // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      iataCode: null == iataCode
          ? _value.iataCode
          : iataCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AirportImpl with DiagnosticableTreeMixin implements _Airport {
  const _$AirportImpl(
      {required this.id,
      required this.airportName,
      required this.city,
      required this.iataCode});

  factory _$AirportImpl.fromJson(Map<String, dynamic> json) =>
      _$$AirportImplFromJson(json);

  @override
  final int id;
  @override
  final String airportName;
  @override
  final String city;
  @override
  final String iataCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Airport(id: $id, airportName: $airportName, city: $city, iataCode: $iataCode)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Airport'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('airportName', airportName))
      ..add(DiagnosticsProperty('city', city))
      ..add(DiagnosticsProperty('iataCode', iataCode));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AirportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.airportName, airportName) ||
                other.airportName == airportName) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.iataCode, iataCode) ||
                other.iataCode == iataCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, airportName, city, iataCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AirportImplCopyWith<_$AirportImpl> get copyWith =>
      __$$AirportImplCopyWithImpl<_$AirportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AirportImplToJson(
      this,
    );
  }
}

abstract class _Airport implements Airport {
  const factory _Airport(
      {required final int id,
      required final String airportName,
      required final String city,
      required final String iataCode}) = _$AirportImpl;

  factory _Airport.fromJson(Map<String, dynamic> json) = _$AirportImpl.fromJson;

  @override
  int get id;
  @override
  String get airportName;
  @override
  String get city;
  @override
  String get iataCode;
  @override
  @JsonKey(ignore: true)
  _$$AirportImplCopyWith<_$AirportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
