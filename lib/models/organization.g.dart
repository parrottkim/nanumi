// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organization _$OrganizationFromJson(Map<String, dynamic> json) => Organization(
      id: json['id'] as String,
      name: json['name'] as String,
      representative: json['representative'] as String,
      website: json['website'] as String,
      area: (json['area'] as List<dynamic>).map((e) => e as String).toList(),
      domain:
          (json['domain'] as List<dynamic>).map((e) => e as String).toList(),
      image: json['image'] as String?,
    );

Organization _$OrganizationFromFirestore(QueryDocumentSnapshot<Map> doc) =>
    Organization(
      id: doc.id,
      name: doc.data()['name'] as String,
      representative: doc.data()['representative'] as String,
      website: doc.data()['website'] as String,
      area: (doc.data()['area'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      domain: (doc.data()['domain'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      image: doc.data()['image'] as String?,
    );

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'representative': instance.representative,
      'website': instance.website,
      'area': instance.area,
      'domain': instance.domain,
      'image': instance.image,
    };
