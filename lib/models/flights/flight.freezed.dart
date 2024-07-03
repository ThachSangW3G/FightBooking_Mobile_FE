// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flight.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Flight _$FlightFromJson(Map<String, dynamic> json) {
  return _Flight.fromJson(json);
}

/// @nodoc
mixin _$Flight {
  int get id => throw _privateConstructorUsedError;
  String get flightStatus => throw _privateConstructorUsedError;
  DateTime get departureDate => throw _privateConstructorUsedError;
  DateTime get arrivalDate => throw _privateConstructorUsedError;
  int get departureAirportId => throw _privateConstructorUsedError;
  int get arrivalAirportId => throw _privateConstructorUsedError;
  int get planeId => throw _privateConstructorUsedError;
  double get economyPrice => throw _privateConstructorUsedError;
  double get businessPrice => throw _privateConstructorUsedError;
  double get firstClassPrice => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  int get airlineId => throw _privateConstructorUsedError;
  String get airlineName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FlightCopyWith<Flight> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlightCopyWith<$Res> {
  factory $FlightCopyWith(Flight value, $Res Function(Flight) then) =
      _$FlightCopyWithImpl<$Res, Flight>;
  @useResult
  $Res call(
      {int id,
      String flightStatus,
      DateTime departureDate,
      DateTime arrivalDate,
      int departureAirportId,
      int arrivalAirportId,
      int planeId,
      double economyPrice,
      double businessPrice,
      double firstClassPrice,
      int duration,
      int airlineId,
      String airlineName});
}

/// @nodoc
class _$FlightCopyWithImpl<$Res, $Val extends Flight>
    implements $FlightCopyWith<$Res> {
  _$FlightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? flightStatus = null,
    Object? departureDate = null,
    Object? arrivalDate = null,
    Object? departureAirportId = null,
    Object? arrivalAirportId = null,
    Object? planeId = null,
    Object? economyPrice = null,
    Object? businessPrice = null,
    Object? firstClassPrice = null,
    Object? duration = null,
    Object? airlineId = null,
    Object? airlineName = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      flightStatus: null == flightStatus
          ? _value.flightStatus
          : flightStatus // ignore: cast_nullable_to_non_nullable
              as String,
      departureDate: null == departureDate
          ? _value.departureDate
          : departureDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      arrivalDate: null == arrivalDate
          ? _value.arrivalDate
          : arrivalDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      departureAirportId: null == departureAirportId
          ? _value.departureAirportId
          : departureAirportId // ignore: cast_nullable_to_non_nullable
              as int,
      arrivalAirportId: null == arrivalAirportId
          ? _value.arrivalAirportId
          : arrivalAirportId // ignore: cast_nullable_to_non_nullable
              as int,
      planeId: null == planeId
          ? _value.planeId
          : planeId // ignore: cast_nullable_to_non_nullable
              as int,
      economyPrice: null == economyPrice
          ? _value.economyPrice
          : economyPrice // ignore: cast_nullable_to_non_nullable
              as double,
      businessPrice: null == businessPrice
          ? _value.businessPrice
          : businessPrice // ignore: cast_nullable_to_non_nullable
              as double,
      firstClassPrice: null == firstClassPrice
          ? _value.firstClassPrice
          : firstClassPrice // ignore: cast_nullable_to_non_nullable
              as double,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      airlineId: null == airlineId
          ? _value.airlineId
          : airlineId // ignore: cast_nullable_to_non_nullable
              as int,
      airlineName: null == airlineName
          ? _value.airlineName
          : airlineName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FlightImplCopyWith<$Res> implements $FlightCopyWith<$Res> {
  factory _$$FlightImplCopyWith(
          _$FlightImpl value, $Res Function(_$FlightImpl) then) =
      __$$FlightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String flightStatus,
      DateTime departureDate,
      DateTime arrivalDate,
      int departureAirportId,
      int arrivalAirportId,
      int planeId,
      double economyPrice,
      double businessPrice,
      double firstClassPrice,
      int duration,
      int airlineId,
      String airlineName});
}

/// @nodoc
class __$$FlightImplCopyWithImpl<$Res>
    extends _$FlightCopyWithImpl<$Res, _$FlightImpl>
    implements _$$FlightImplCopyWith<$Res> {
  __$$FlightImplCopyWithImpl(
      _$FlightImpl _value, $Res Function(_$FlightImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? flightStatus = null,
    Object? departureDate = null,
    Object? arrivalDate = null,
    Object? departureAirportId = null,
    Object? arrivalAirportId = null,
    Object? planeId = null,
    Object? economyPrice = null,
    Object? businessPrice = null,
    Object? firstClassPrice = null,
    Object? duration = null,
    Object? airlineId = null,
    Object? airlineName = null,
  }) {
    return _then(_$FlightImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      flightStatus: null == flightStatus
          ? _value.flightStatus
          : flightStatus // ignore: cast_nullable_to_non_nullable
              as String,
      departureDate: null == departureDate
          ? _value.departureDate
          : departureDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      arrivalDate: null == arrivalDate
          ? _value.arrivalDate
          : arrivalDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      departureAirportId: null == departureAirportId
          ? _value.departureAirportId
          : departureAirportId // ignore: cast_nullable_to_non_nullable
              as int,
      arrivalAirportId: null == arrivalAirportId
          ? _value.arrivalAirportId
          : arrivalAirportId // ignore: cast_nullable_to_non_nullable
              as int,
      planeId: null == planeId
          ? _value.planeId
          : planeId // ignore: cast_nullable_to_non_nullable
              as int,
      economyPrice: null == economyPrice
          ? _value.economyPrice
          : economyPrice // ignore: cast_nullable_to_non_nullable
              as double,
      businessPrice: null == businessPrice
          ? _value.businessPrice
          : businessPrice // ignore: cast_nullable_to_non_nullable
              as double,
      firstClassPrice: null == firstClassPrice
          ? _value.firstClassPrice
          : firstClassPrice // ignore: cast_nullable_to_non_nullable
              as double,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      airlineId: null == airlineId
          ? _value.airlineId
          : airlineId // ignore: cast_nullable_to_non_nullable
              as int,
      airlineName: null == airlineName
          ? _value.airlineName
          : airlineName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FlightImpl with DiagnosticableTreeMixin implements _Flight {
  const _$FlightImpl(
      {required this.id,
      required this.flightStatus,
      required this.departureDate,
      required this.arrivalDate,
      required this.departureAirportId,
      required this.arrivalAirportId,
      required this.planeId,
      required this.economyPrice,
      required this.businessPrice,
      required this.firstClassPrice,
      required this.duration,
      required this.airlineId,
      required this.airlineName});

  factory _$FlightImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlightImplFromJson(json);

  @override
  final int id;
  @override
  final String flightStatus;
  @override
  final DateTime departureDate;
  @override
  final DateTime arrivalDate;
  @override
  final int departureAirportId;
  @override
  final int arrivalAirportId;
  @override
  final int planeId;
  @override
  final double economyPrice;
  @override
  final double businessPrice;
  @override
  final double firstClassPrice;
  @override
  final int duration;
  @override
  final int airlineId;
  @override
  final String airlineName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Flight(id: $id, flightStatus: $flightStatus, departureDate: $departureDate, arrivalDate: $arrivalDate, departureAirportId: $departureAirportId, arrivalAirportId: $arrivalAirportId, planeId: $planeId, economyPrice: $economyPrice, businessPrice: $businessPrice, firstClassPrice: $firstClassPrice, duration: $duration, airlineId: $airlineId, airlineName: $airlineName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Flight'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('flightStatus', flightStatus))
      ..add(DiagnosticsProperty('departureDate', departureDate))
      ..add(DiagnosticsProperty('arrivalDate', arrivalDate))
      ..add(DiagnosticsProperty('departureAirportId', departureAirportId))
      ..add(DiagnosticsProperty('arrivalAirportId', arrivalAirportId))
      ..add(DiagnosticsProperty('planeId', planeId))
      ..add(DiagnosticsProperty('economyPrice', economyPrice))
      ..add(DiagnosticsProperty('businessPrice', businessPrice))
      ..add(DiagnosticsProperty('firstClassPrice', firstClassPrice))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('airlineId', airlineId))
      ..add(DiagnosticsProperty('airlineName', airlineName));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlightImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.flightStatus, flightStatus) ||
                other.flightStatus == flightStatus) &&
            (identical(other.departureDate, departureDate) ||
                other.departureDate == departureDate) &&
            (identical(other.arrivalDate, arrivalDate) ||
                other.arrivalDate == arrivalDate) &&
            (identical(other.departureAirportId, departureAirportId) ||
                other.departureAirportId == departureAirportId) &&
            (identical(other.arrivalAirportId, arrivalAirportId) ||
                other.arrivalAirportId == arrivalAirportId) &&
            (identical(other.planeId, planeId) || other.planeId == planeId) &&
            (identical(other.economyPrice, economyPrice) ||
                other.economyPrice == economyPrice) &&
            (identical(other.businessPrice, businessPrice) ||
                other.businessPrice == businessPrice) &&
            (identical(other.firstClassPrice, firstClassPrice) ||
                other.firstClassPrice == firstClassPrice) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.airlineId, airlineId) ||
                other.airlineId == airlineId) &&
            (identical(other.airlineName, airlineName) ||
                other.airlineName == airlineName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      flightStatus,
      departureDate,
      arrivalDate,
      departureAirportId,
      arrivalAirportId,
      planeId,
      economyPrice,
      businessPrice,
      firstClassPrice,
      duration,
      airlineId,
      airlineName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FlightImplCopyWith<_$FlightImpl> get copyWith =>
      __$$FlightImplCopyWithImpl<_$FlightImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FlightImplToJson(
      this,
    );
  }
}

abstract class _Flight implements Flight {
  const factory _Flight(
      {required final int id,
      required final String flightStatus,
      required final DateTime departureDate,
      required final DateTime arrivalDate,
      required final int departureAirportId,
      required final int arrivalAirportId,
      required final int planeId,
      required final double economyPrice,
      required final double businessPrice,
      required final double firstClassPrice,
      required final int duration,
      required final int airlineId,
      required final String airlineName}) = _$FlightImpl;

  factory _Flight.fromJson(Map<String, dynamic> json) = _$FlightImpl.fromJson;

  @override
  int get id;
  @override
  String get flightStatus;
  @override
  DateTime get departureDate;
  @override
  DateTime get arrivalDate;
  @override
  int get departureAirportId;
  @override
  int get arrivalAirportId;
  @override
  int get planeId;
  @override
  double get economyPrice;
  @override
  double get businessPrice;
  @override
  double get firstClassPrice;
  @override
  int get duration;
  @override
  int get airlineId;
  @override
  String get airlineName;
  @override
  @JsonKey(ignore: true)
  _$$FlightImplCopyWith<_$FlightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
