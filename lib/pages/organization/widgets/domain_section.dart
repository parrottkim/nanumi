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
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
