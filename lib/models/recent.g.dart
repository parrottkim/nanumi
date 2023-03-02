// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recent _$RecentFromJson(Map<String, dynamic> json) => Recent(
      organization:
          Organization.fromJson(json['organization'] as Map<String, dynamic>),
      comment: Comment.fromJson(json['comment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecentToJson(Recent instance) => <String, dynamic>{
      'organization': instance.organization,
      'comment': instance.comment,
    };
