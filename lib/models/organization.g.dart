// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************************************************************

_$_Organization _$$_OrganizationFromFirestore(QueryDocumentSnapshot<Map> doc) =>
    _$_Organization(
      id: doc.id,
      name: doc.data()['name'] as String,
      representative: doc.data()['representative'] as String,
      website: doc.data()['website'] as String,
      likes: doc.data()['likes'] as int,
      area: (doc.data()['area'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      domain: (doc.data()['domain'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      image: doc.data()['image'] as String?,
    );

_$_Organization _$$_OrganizationFromJson(Map<String, dynamic> json) =>
    _$_Organization(
      id: json['id'] as String,
      name: json['name'],
      representative: json['representative'],
      website: json['website'],
      likes: json['likes'] as int,
      area: (json['area'] as List<dynamic>).map((e) => e as String).toList(),
      domain: json['domain'],
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$_OrganizationToJson(_$_Organization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'representative': instance.representative,
      'website': instance.website,
      'likes': instance.likes,
      'area': instance.area,
      'domain': instance.domain,
      'image': instance.image,
    };
