import 'package:json_annotation/json_annotation.dart';

part 'organization.g.dart';

@JsonSerializable()
class Organization {
  final String name, representative, website;
  final List<String> area, domain;

  Organization({
    required this.name,
    required this.representative,
    required this.website,
    required this.area,
    required this.domain,
  });

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}
