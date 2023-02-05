import 'package:json_annotation/json_annotation.dart';

part 'organization.g.dart';

@JsonSerializable()
class Organization {
  final String area, domain, name, representative, website;

  Organization({
    required this.area,
    required this.domain,
    required this.name,
    required this.representative,
    required this.website,
  });

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}
