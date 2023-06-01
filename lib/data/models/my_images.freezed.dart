// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_images.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyImage _$MyImageFromJson(Map<String, dynamic> json) {
  return _MyImage.fromJson(json);
}

/// @nodoc
mixin _$MyImage {
  String? get name => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyImageCopyWith<MyImage> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyImageCopyWith<$Res> {
  factory $MyImageCopyWith(MyImage value, $Res Function(MyImage) then) =
      _$MyImageCopyWithImpl<$Res, MyImage>;
  @useResult
  $Res call({String? name, String? link});
}

/// @nodoc
class _$MyImageCopyWithImpl<$Res, $Val extends MyImage>
    implements $MyImageCopyWith<$Res> {
  _$MyImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? link = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MyImageCopyWith<$Res> implements $MyImageCopyWith<$Res> {
  factory _$$_MyImageCopyWith(
          _$_MyImage value, $Res Function(_$_MyImage) then) =
      __$$_MyImageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? link});
}

/// @nodoc
class __$$_MyImageCopyWithImpl<$Res>
    extends _$MyImageCopyWithImpl<$Res, _$_MyImage>
    implements _$$_MyImageCopyWith<$Res> {
  __$$_MyImageCopyWithImpl(_$_MyImage _value, $Res Function(_$_MyImage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? link = freezed,
  }) {
    return _then(_$_MyImage(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MyImage with DiagnosticableTreeMixin implements _MyImage {
  const _$_MyImage({required this.name, required this.link});

  factory _$_MyImage.fromJson(Map<String, dynamic> json) =>
      _$$_MyImageFromJson(json);

  @override
  final String? name;
  @override
  final String? link;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MyImage(name: $name, link: $link)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MyImage'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('link', link));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyImage &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.link, link) || other.link == link));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, link);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MyImageCopyWith<_$_MyImage> get copyWith =>
      __$$_MyImageCopyWithImpl<_$_MyImage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MyImageToJson(
      this,
    );
  }
}

abstract class _MyImage implements MyImage {
  const factory _MyImage(
      {required final String? name, required final String? link}) = _$_MyImage;

  factory _MyImage.fromJson(Map<String, dynamic> json) = _$_MyImage.fromJson;

  @override
  String? get name;
  @override
  String? get link;
  @override
  @JsonKey(ignore: true)
  _$$_MyImageCopyWith<_$_MyImage> get copyWith =>
      throw _privateConstructorUsedError;
}
