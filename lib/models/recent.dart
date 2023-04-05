import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nanumi/models/comment.dart';
import 'package:nanumi/models/organization.dart';

part 'recent.freezed.dart';
part 'recent.g.dart';

@freezed
class Recent with _$Recent {
  const factory Recent({
    required Organization organization,
    required Comment comment,
  }) = _Recent;

  factory Recent.fromJson(Map<String, Object?> json) => _$RecentFromJson(json);
}
