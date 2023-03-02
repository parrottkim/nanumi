import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nanumi/models/comment.dart';
import 'package:nanumi/models/organization.dart';

part 'recent.g.dart';

@JsonSerializable()
class Recent {
  final Organization organization;
  final Comment comment;

  Recent({
    required this.organization,
    required this.comment,
  });

  factory Recent.fromJson(Map<String, dynamic> json) => _$RecentFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RecentToJson(this);
}
