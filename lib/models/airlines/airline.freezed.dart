// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'airline.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Airline _$AirlineFromJson(Map<String, dynamic> json) {
  return _Airline.fromJson(json);
}

/// @nodoc
mixin _$Airline {
  int get id => throw _privateConstructorUsedError;
  String get airlineName => throw _privateConstructorUsedError;
  String get logoUrl => throw _privateConstructorUsedError;
  List<String> get picture => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AirlineCopyWith<Airline> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AirlineCopyWith<$Res> {
  factory $AirlineCopyWith(Airline value, $Res Function(Airline) then) =
      _$AirlineCopyWithImpl<$Res, Airline>;
  @useResult
  $Res call({int id, String airlineName, String logoUrl, List<String> picture});
}

/// @nodoc
class _$AirlineCopyWithImpl<$Res, $Val extends Airline>
    implements $AirlineCopyWith<$Res> {
  _$AirlineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? airlineName = null,
    Object? logoUrl = null,
    Object? picture = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      airlineName: null == airlineName
          ? _value.airlineName
          : airlineName // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: null == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      picture: null == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AirlineImplCopyWith<$Res> implements $AirlineCopyWith<$Res> {
  factory _$$AirlineImplCopyWith(
          _$AirlineImpl value, $Res Function(_$AirlineImpl) then) =
      __$$AirlineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String airlineName, String logoUrl, List<String> picture});
}

/// @nodoc
class __$$AirlineImplCopyWithImpl<$Res>
    extends _$AirlineCopyWithImpl<$Res, _$AirlineImpl>
    implements _$$AirlineImplCopyWith<$Res> {
  __$$AirlineImplCopyWithImpl(
      _$AirlineImpl _value, $Res Function(_$AirlineImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? airlineName = null,
    Object? logoUrl = null,
    Object? picture = null,
  }) {
    return _then(_$AirlineImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      airlineName: null == airlineName
          ? _value.airlineName
          : airlineName // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: null == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      picture: null == picture
          ? _value._picture
          : picture // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AirlineImpl with DiagnosticableTreeMixin implements _Airline {
  const _$AirlineImpl(
      {required this.id,
      required this.airlineName,
      required this.logoUrl,
      required final List<String> picture})
      : _picture = picture;

  factory _$AirlineImpl.fromJson(Map<String, dynamic> json) =>
      _$$AirlineImplFromJson(json);

  @override
  final int id;
  @override
  final String airlineName;
  @override
  final String logoUrl;
  final List<String> _picture;
  @override
  List<String> get picture {
    if (_picture is EqualUnmodifiableListView) return _picture;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_picture);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Airline(id: $id, airlineName: $airlineName, logoUrl: $logoUrl, picture: $picture)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Airline'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('airlineName', airlineName))
      ..add(DiagnosticsProperty('logoUrl', logoUrl))
      ..add(DiagnosticsProperty('picture', picture));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AirlineImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.airlineName, airlineName) ||
                other.airlineName == airlineName) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            const DeepCollectionEquality().equals(other._picture, _picture));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, airlineName, logoUrl,
      const DeepCollectionEquality().hash(_picture));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AirlineImplCopyWith<_$AirlineImpl> get copyWith =>
      __$$AirlineImplCopyWithImpl<_$AirlineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AirlineImplToJson(
      this,
    );
  }
}

abstract class _Airline implements Airline {
  const factory _Airline(
      {required final int id,
      required final String airlineName,
      required final String logoUrl,
      required final List<String> picture}) = _$AirlineImpl;

  factory _Airline.fromJson(Map<String, dynamic> json) = _$AirlineImpl.fromJson;

  @override
  int get id;
  @override
  String get airlineName;
  @override
  String get logoUrl;
  @override
  List<String> get picture;
  @override
  @JsonKey(ignore: true)
  _$$AirlineImplCopyWith<_$AirlineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
