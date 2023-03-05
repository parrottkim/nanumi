import 'package:flutter/material.dart';
import 'package:nanumi/models/organization.dart';

class AreaSection extends StatelessWidget {
  const AreaSection({
    Key? key,
    required this.organization,
    this.isShrink = false,
  }) : super(key: key);

  final Organization organization;
  final bool isShrink;

  @override
  Widget build(BuildContext context) {
    return isShrink
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              organization.area.length > 1
                  ? '${organization.area[0]} 외 ${organization.area.length - 1}개국'
                  : '${organization.area[0]}',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
          )
        : Wrap(
            direction: Axis.horizontal,
            spacing: 4.0,
            runSpacing: 8.0,
            children: List.generate(
              organization.area.length,
              (index) => Container(
                padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  organization.area[index],
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
  }
}
