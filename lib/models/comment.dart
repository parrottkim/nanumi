import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final String id, text, device, deviceId;
  final DateTime date;

  Comment({
    required this.id,
    required this.text,
    required this.device,
    required this.deviceId,
    required this.date,
  });

  factory Comment.fromFirestore(QueryDocumentSnapshot<Map> doc) =>
      _$CommentFromFirestore(doc);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
