import 'package:flutter/material.dart';
import 'package:nanumi/models/organization.dart';

class DomainSection extends StatelessWidget {
  const DomainSection({
    Key? key,
    required this.organization,
  }) : super(key: key);

  final Organization organization;

  @override
  Widget build(BuildContext context) {
    return Text(
      organization.domain.join(', '),
      style: TextStyle(
          fontWeight: FontWeight.w400, fontSize: 14.0, color: Colors.grey[700]),
    );
  }
}
