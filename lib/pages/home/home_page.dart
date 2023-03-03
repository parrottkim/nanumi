import 'package:flutter/material.dart';
import 'package:nanumi/pages/home/widgets/home_appbar.dart';
import 'package:nanumi/pages/home/widgets/popular_organization.dart';
import 'package:nanumi/pages/home/widgets/recent_comment.dart';
import 'package:nanumi/widgets/inline_advertise.dart';
import 'package:nanumi/widgets/default_appbar.dart';
import 'package:nanumi/widgets/elevated_icon_button.dart';
import 'package:nanumi/widgets/default_icon_button.dart';
import 'package:nanumi/widgets/logo.dart';
import 'package:unicons/unicons.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        elevation: 0.0,
        title: Logo(),
        action: [
          DefaultIconButton(
            onPressed: () => Navigator.pushNamed(context, '/setting'),
            icon: Icon(UniconsLine.cog),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.0),
            InlineAdvertise(),
            SizedBox(height: 20.0),
            PopularOrganization(),
            SizedBox(height: 20.0),
            RecentComment(),
          ],
        ),
      ),
    );
  }
}
