import 'package:flutter/material.dart';
import 'package:nanumi/models/organization.dart';

class AreaSection extends StatelessWidget {
  const AreaSection({
    Key? key,
    required this.organization,
  }) : super(key: key);

  final Organization organization;

  @override
  Widget build(BuildContext context) {
    return Wrap(
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
