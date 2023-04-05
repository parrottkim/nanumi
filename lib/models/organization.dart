import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nanumi/models/comment.dart';

part 'organization.freezed.dart';
part 'organization.g.dart';

@freezed
class Organization with _$Organization {
  const factory Organization({
    required String id,
    name,
    representative,
    website,
    required int likes,
    required List<String> area,
    domain,
    String? image,
  }) = _Organization;

  factory Organization.fromJson(Map<String, Object?> json) =>
      _$OrganizationFromJson(json);

  factory Organization.fromFirestore(QueryDocumentSnapshot<Map> doc) =>
      _$OrganizationFromFirestore(doc);
}

// class Organization {
//   final String id, name, representative, website;
//   late final int likes;
//   final List<String> area, domain;
//   final String? image;

//   Organization({
//     required this.id,
//     required this.name,
//     required this.representative,
//     required this.website,
//     required this.likes,
//     required this.area,
//     required this.domain,
//     this.image,
//   });

//   factory Organization.fromJson(Map<String, dynamic> json) =>
//       _$OrganizationFromJson(json);

//   factory Organization.fromFirestore(QueryDocumentSnapshot<Map> doc) =>
//       _$OrganizationFromFirestore(doc);

//   /// Connect the generated [_$PersonToJson] function to the `toJson` method.
//   Map<String, dynamic> toJson() => _$OrganizationToJson(this);
// }
