import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    String? id,
    required String organizationId,
    required String text,
    required String device,
    required String deviceId,
    required DateTime createdAt,
    @Default(false) bool isReported,
  }) = _Comment;

  factory Comment.fromJson(Map<String, Object?> json) =>
      _$CommentFromJson(json);

  factory Comment.fromFirestore(QueryDocumentSnapshot<Map> doc) =>
      _$CommentFromFirestore(doc);
}
