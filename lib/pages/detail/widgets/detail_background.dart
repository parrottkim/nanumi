import 'package:flutter/material.dart';
import 'package:nanumi/models/organization.dart';

class DetailBackground extends StatelessWidget {
  const DetailBackground({
    Key? key,
    required this.organization,
  }) : super(key: key);

  final Organization organization;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: organization.image == null
              ? AssetImage(
                  'assets/images/default_background.jpg',
                ) as ImageProvider
              : NetworkImage(organization.image!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
