// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as String,
      text: json['text'] as String,
      device: json['device'] as String,
      deviceId: json['deviceId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Comment _$CommentFromFirestore(QueryDocumentSnapshot<Map> doc) => Comment(
      id: doc.data()['id'] as String,
      text: doc.data()['text'] as String,
      device: doc.data()['device'] as String,
      deviceId: doc.data()['deviceId'] as String,
      createdAt: doc.data()['createdAt'].toDate(),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'device': instance.device,
      'deviceId': instance.deviceId,
      'createdAt': instance.createdAt,
    };
