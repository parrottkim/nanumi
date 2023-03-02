import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization.g.dart';

@JsonSerializable()
class Organization {
  final String id, name, representative, website;
  final List<String> area, domain;
  final String? image;

  Organization({
    required this.id,
    required this.name,
    required this.representative,
    required this.website,
    required this.area,
    required this.domain,
    this.image,
  });

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);

  factory Organization.fromFirestore(QueryDocumentSnapshot<Map> doc) =>
      _$OrganizationFromFirestore(doc);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}
