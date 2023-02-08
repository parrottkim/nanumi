import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/pages/detail/argument/detail_argument.dart';
import 'package:nanumi/pages/organization/widgets/area_section.dart';
import 'package:nanumi/pages/organization/widgets/domain_section.dart';
import 'package:unicons/unicons.dart';

class OrganizationListItem extends StatelessWidget {
  const OrganizationListItem({
    Key? key,
    required this.organization,
  }) : super(key: key);

  final Organization organization;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        '/detail',
        arguments: DetailArgument(organization: organization),
      ),
      borderRadius: BorderRadius.circular(16.0),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 0.0,
              blurRadius: 2.0,
              offset: Offset(0, 3),
            ),
          ],
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  organization.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      UniconsLine.thumbs_up,
                      size: 16.0,
                    ),
                    SizedBox(width: 4.0),
                    Text('${organization.likes}'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 6.0),
            DomainSection(
              organization: organization,
            ),
            SizedBox(height: 16.0),
            AreaSection(
              organization: organization,
            ),
          ],
        ),
      ),
    );
  }
}
