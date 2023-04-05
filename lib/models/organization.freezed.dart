// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Organization _$OrganizationFromJson(Map<String, dynamic> json) {
  return _Organization.fromJson(json);
}

Organization _$OrganizationFromFirestore(QueryDocumentSnapshot<Map> doc) {
  return _Organization.fromFirestore(doc);
}

/// @nodoc
mixin _$Organization {
  String get id => throw _privateConstructorUsedError;
  dynamic get name => throw _privateConstructorUsedError;
  dynamic get representative => throw _privateConstructorUsedError;
  dynamic get website => throw _privateConstructorUsedError;
  int get likes => throw _privateConstructorUsedError;
  List<String> get area => throw _privateConstructorUsedError;
  dynamic get domain => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrganizationCopyWith<Organization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationCopyWith<$Res> {
  factory $OrganizationCopyWith(
          Organization value, $Res Function(Organization) then) =
      _$OrganizationCopyWithImpl<$Res, Organization>;
  @useResult
  $Res call(
      {String id,
      dynamic name,
      dynamic representative,
      dynamic website,
      int likes,
      List<String> area,
      dynamic domain,
      String? image});
}

/// @nodoc
class _$OrganizationCopyWithImpl<$Res, $Val extends Organization>
    implements $OrganizationCopyWith<$Res> {
  _$OrganizationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? representative = freezed,
    Object? website = freezed,
    Object? likes = null,
    Object? area = null,
    Object? domain = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as dynamic,
      representative: freezed == representative
          ? _value.representative
          : representative // ignore: cast_nullable_to_non_nullable
              as dynamic,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as dynamic,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as List<String>,
      domain: freezed == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as dynamic,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrganizationCopyWith<$Res>
    implements $OrganizationCopyWith<$Res> {
  factory _$$_OrganizationCopyWith(
          _$_Organization value, $Res Function(_$_Organization) then) =
      __$$_OrganizationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      dynamic name,
      dynamic representative,
      dynamic website,
      int likes,
      List<String> area,
      dynamic domain,
      String? image});
}

/// @nodoc
class __$$_OrganizationCopyWithImpl<$Res>
    extends _$OrganizationCopyWithImpl<$Res, _$_Organization>
    implements _$$_OrganizationCopyWith<$Res> {
  __$$_OrganizationCopyWithImpl(
      _$_Organization _value, $Res Function(_$_Organization) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? representative = freezed,
    Object? website = freezed,
    Object? likes = null,
    Object? area = null,
    Object? domain = freezed,
    Object? image = freezed,
  }) {
    return _then(_$_Organization(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name ? _value.name! : name,
      representative:
          freezed == representative ? _value.representative! : representative,
      website: freezed == website ? _value.website! : website,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      area: null == area
          ? _value._area
          : area // ignore: cast_nullable_to_non_nullable
              as List<String>,
      domain: freezed == domain ? _value.domain! : domain,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Organization implements _Organization {
  const _$_Organization(
      {required this.id,
      this.name,
      this.representative,
      this.website,
      required this.likes,
      required final List<String> area,
      this.domain,
      this.image})
      : _area = area;

  factory _$_Organization.fromJson(Map<String, dynamic> json) =>
      _$$_OrganizationFromJson(json);

  factory _$_Organization.fromFirestore(QueryDocumentSnapshot<Map> doc) =>
      _$$_OrganizationFromFirestore(doc);

  @override
  final String id;
  @override
  final dynamic name;
  @override
  final dynamic representative;
  @override
  final dynamic website;
  @override
  final int likes;
  final List<String> _area;
  @override
  List<String> get area {
    if (_area is EqualUnmodifiableListView) return _area;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_area);
  }

  @override
  final dynamic domain;
  @override
  @override
  final String? image;

  @override
  String toString() {
    return 'Organization(id: $id, name: $name, representative: $representative, website: $website, likes: $likes, area: $area, domain: $domain, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Organization &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.representative, representative) &&
            const DeepCollectionEquality().equals(other.website, website) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            const DeepCollectionEquality().equals(other._area, _area) &&
            const DeepCollectionEquality().equals(other.domain, domain) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(representative),
      const DeepCollectionEquality().hash(website),
      likes,
      const DeepCollectionEquality().hash(_area),
      const DeepCollectionEquality().hash(domain),
      image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrganizationCopyWith<_$_Organization> get copyWith =>
      __$$_OrganizationCopyWithImpl<_$_Organization>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrganizationToJson(
      this,
    );
  }
}

abstract class _Organization implements Organization {
  const factory _Organization(
      {required final String id,
      final dynamic name,
      final dynamic representative,
      final dynamic website,
      required final int likes,
      required final List<String> area,
      final dynamic domain,
      final String? image}) = _$_Organization;

  factory _Organization.fromJson(Map<String, dynamic> json) =
      _$_Organization.fromJson;

  factory _Organization.fromFirestore(QueryDocumentSnapshot<Map> doc) =
      _$_Organization.fromFirestore;

  @override
  String get id;
  @override
  dynamic get name;
  @override
  dynamic get representative;
  @override
  dynamic get website;
  @override
  int get likes;
  @override
  List<String> get area;
  @override
  dynamic get domain;
  @override
  String? get image;
  @override
  @JsonKey(ignore: true)
  _$$_OrganizationCopyWith<_$_Organization> get copyWith =>
      throw _privateConstructorUsedError;
}
