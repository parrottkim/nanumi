// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organization _$OrganizationFromJson(Map<String, dynamic> json) => Organization(
      area: json['area'] as String,
      domain: json['domain'] as String,
      name: json['name'] as String,
      representative: json['representative'] as String,
      website: json['website'] as String,
    );

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'area': instance.area,
      'domain': instance.domain,
      'name': instance.name,
      'representative': instance.representative,
      'website': instance.website,
    };
