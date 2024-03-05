// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromFirestore(QueryDocumentSnapshot<Map> doc) {
  print(doc.data()['createdAt'].runtimeType);
  return _$_Comment(
    id: doc.id,
    organizationId: doc.data()['organizationId'] as String,
    text: doc.data()['text'] as String,
    device: doc.data()['device'] as String,
    deviceId: doc.data()['deviceId'] as String,
    createdAt: doc.data()['createdAt'].toDate(),
    isReported: doc.data()['isReported'] as bool? ?? false,
  );
}

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      id: json['id'] as String?,
      organizationId: json['organizationId'] as String,
      text: json['text'] as String,
      device: json['device'] as String,
      deviceId: json['deviceId'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      isReported: json['isReported'] as bool? ?? false,
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'text': instance.text,
      'device': instance.device,
      'deviceId': instance.deviceId,
      'createdAt': Timestamp.fromDate(instance.createdAt),
      'isReported': instance.isReported,
    };
