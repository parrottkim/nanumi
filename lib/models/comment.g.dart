// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromFirestore(QueryDocumentSnapshot<Map> doc) => Comment(
      id: doc.data()['id'] as String,
      text: doc.data()['text'] as String,
      device: doc.data()['device'] as String,
      deviceId: doc.data()['deviceId'] as String,
      date: DateTime.parse(doc.data()['date'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'device': instance.device,
      'deviceId': instance.deviceId,
      'date': instance.date.toIso8601String(),
    };
