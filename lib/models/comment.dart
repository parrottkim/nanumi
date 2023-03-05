import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    required String id,
    text,
    device,
    deviceId,
    required DateTime createdAt,
  }) = _Comment;

  factory Comment.fromJson(Map<String, Object?> json) =>
      _$CommentFromJson(json);

  factory Comment.fromFirestore(QueryDocumentSnapshot<Map> doc) =>
      _$CommentFromFirestore(doc);
}

// @freezed
// class Comment {
//   final String id, text, device, deviceId;
//   final DateTime createdAt;

//   Comment({
//     required this.id,
//     required this.text,
//     required this.device,
//     required this.deviceId,
//     required this.createdAt,
//   });

//   factory Comment.fromJson(Map<String, dynamic> json) =>
//       _$CommentFromJson(json);

//   factory Comment.fromFirestore(QueryDocumentSnapshot<Map> doc) =>
//       _$CommentFromFirestore(doc);

//   /// Connect the generated [_$PersonToJson] function to the `toJson` method.
//   Map<String, dynamic> toJson() => _$CommentToJson(this);
// }
