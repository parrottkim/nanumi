// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Recent _$$_RecentFromJson(Map<String, dynamic> json) => _$_Recent(
      organization:
          Organization.fromJson(json['organization'] as Map<String, dynamic>),
      comment: Comment.fromJson(json['comment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_RecentToJson(_$_Recent instance) => <String, dynamic>{
      'organization': instance.organization,
      'comment': instance.comment,
    };
