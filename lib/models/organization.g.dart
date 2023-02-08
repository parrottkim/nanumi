// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organization _$OrganizationFromJson(Map<String, dynamic> json) => Organization(
      name: json['name'] as String,
      representative: json['representative'] as String,
      website: json['website'] as String,
      area: (json['area'] as List<dynamic>).map((e) => e as String).toList(),
      domain:
          (json['domain'] as List<dynamic>).map((e) => e as String).toList(),
      likes: json['likes'] as int,
    );

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'name': instance.name,
      'representative': instance.representative,
      'website': instance.website,
      'area': instance.area,
      'domain': instance.domain,
      'likes': instance.likes,
    };
