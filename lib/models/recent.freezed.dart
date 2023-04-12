// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Recent _$RecentFromJson(Map<String, dynamic> json) {
  return _Recent.fromJson(json);
}

/// @nodoc
mixin _$Recent {
  Organization get organization => throw _privateConstructorUsedError;
  Comment get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecentCopyWith<Recent> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentCopyWith<$Res> {
  factory $RecentCopyWith(Recent value, $Res Function(Recent) then) =
      _$RecentCopyWithImpl<$Res, Recent>;
  @useResult
  $Res call({Organization organization, Comment comment});

  $OrganizationCopyWith<$Res> get organization;
  $CommentCopyWith<$Res> get comment;
}

/// @nodoc
class _$RecentCopyWithImpl<$Res, $Val extends Recent>
    implements $RecentCopyWith<$Res> {
  _$RecentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organization = null,
    Object? comment = null,
  }) {
    return _then(_value.copyWith(
      organization: null == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as Organization,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as Comment,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OrganizationCopyWith<$Res> get organization {
    return $OrganizationCopyWith<$Res>(_value.organization, (value) {
      return _then(_value.copyWith(organization: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CommentCopyWith<$Res> get comment {
    return $CommentCopyWith<$Res>(_value.comment, (value) {
      return _then(_value.copyWith(comment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RecentCopyWith<$Res> implements $RecentCopyWith<$Res> {
  factory _$$_RecentCopyWith(_$_Recent value, $Res Function(_$_Recent) then) =
      __$$_RecentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Organization organization, Comment comment});

  @override
  $OrganizationCopyWith<$Res> get organization;
  @override
  $CommentCopyWith<$Res> get comment;
}

/// @nodoc
class __$$_RecentCopyWithImpl<$Res>
    extends _$RecentCopyWithImpl<$Res, _$_Recent>
    implements _$$_RecentCopyWith<$Res> {
  __$$_RecentCopyWithImpl(_$_Recent _value, $Res Function(_$_Recent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organization = null,
    Object? comment = null,
  }) {
    return _then(_$_Recent(
      organization: null == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as Organization,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as Comment,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Recent implements _Recent {
  const _$_Recent({required this.organization, required this.comment});

  factory _$_Recent.fromJson(Map<String, dynamic> json) =>
      _$$_RecentFromJson(json);

  @override
  final Organization organization;
  @override
  final Comment comment;

  @override
  String toString() {
    return 'Recent(organization: $organization, comment: $comment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Recent &&
            (identical(other.organization, organization) ||
                other.organization == organization) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, organization, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecentCopyWith<_$_Recent> get copyWith =>
      __$$_RecentCopyWithImpl<_$_Recent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecentToJson(
      this,
    );
  }
}

abstract class _Recent implements Recent {
  const factory _Recent(
      {required final Organization organization,
      required final Comment comment}) = _$_Recent;

  factory _Recent.fromJson(Map<String, dynamic> json) = _$_Recent.fromJson;

  @override
  Organization get organization;
  @override
  Comment get comment;
  @override
  @JsonKey(ignore: true)
  _$$_RecentCopyWith<_$_Recent> get copyWith =>
      throw _privateConstructorUsedError;
}
