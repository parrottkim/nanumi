import 'package:flutter/material.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/pages/home/widgets/home_list_item.dart';

class HomeList extends StatelessWidget {
  const HomeList({
    Key? key,
    required this.organizations,
  }) : super(key: key);

  final List<Organization> organizations;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16.0),
      itemCount: organizations.length,
      itemBuilder: (context, index) => HomeListItem(
        organization: organizations[index],
      ),
      separatorBuilder: (context, index) => SizedBox(height: 16.0),
    );
  }
}
