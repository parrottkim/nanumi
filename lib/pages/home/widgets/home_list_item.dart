import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/pages/home/widgets/area_section.dart';
import 'package:nanumi/pages/home/widgets/domain_section.dart';

class HomeListItem extends StatelessWidget {
  const HomeListItem({
    Key? key,
    required this.organization,
  }) : super(key: key);

  final Organization organization;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2.0,
            blurRadius: 4.0,
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.white,
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
                    FontAwesomeIcons.thumbsUp,
                    size: 16.0,
                  ),
                  SizedBox(width: 4.0),
                  Text(Random().nextInt(30).toString()),
                ],
              ),
            ],
          ),
          SizedBox(height: 6.0),
          DomainSection(
            organization: organization,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[100],
            ),
          ),
          AreaSection(
            organization: organization,
          ),
        ],
      ),
    );
  }
}
