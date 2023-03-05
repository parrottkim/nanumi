// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromFirestore(QueryDocumentSnapshot<Map> doc) =>
    _$_Comment(
      id: doc.data()['id'] as String,
      text: doc.data()['text'] as String,
      device: doc.data()['device'] as String,
      deviceId: doc.data()['deviceId'] as String,
      createdAt: doc.data()['createdAt'].toDate(),
    );

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      id: json['id'] as String,
      text: json['text'],
      device: json['device'],
      deviceId: json['deviceId'],
      createdAt: json['createdAt'].toDate(),
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'device': instance.device,
      'deviceId': instance.deviceId,
      'createdAt': instance.createdAt,
    };
