import 'package:flutter/material.dart';
import 'package:nanumi/models/organization.dart';

class DomainSection extends StatelessWidget {
  const DomainSection({
    Key? key,
    required this.organization,
    this.isShrink = false,
  }) : super(key: key);

  final Organization organization;
  final bool isShrink;

  @override
  Widget build(BuildContext context) {
    var text = isShrink
        ? organization.domain.length > 1
            ? '${organization.domain[0]} 외 ${organization.domain.length - 1}건'
            : '${organization.domain[0]}'
        : organization.domain.join(', ');
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
