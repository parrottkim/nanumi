import 'package:flutter/material.dart';
import 'package:nanumi/pages/dashboard/widgets/dashboard_appbar.dart';
import 'package:nanumi/pages/detail/argument/detail_argument.dart';
import 'package:nanumi/pages/detail/widgets/detail_content.dart';
import 'package:nanumi/widgets/leading_button.dart';
import 'package:unicons/unicons.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)!.settings.arguments as DetailArgument;

    return Scaffold(
      appBar: DashboardAppBar(
        centerTitle: true,
        leading: LeadingButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${argument.organization.name}',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
              ),
            ),
            Text(
              '${argument.organization.name}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
      body: DetailContent(
        organization: argument.organization,
      ),
    );
  }
}
