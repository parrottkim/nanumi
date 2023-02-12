import 'package:flutter/material.dart';
import 'package:nanumi/pages/dashboard/widgets/dashboard_appbar.dart';
import 'package:nanumi/pages/detail/argument/detail_argument.dart';
import 'package:nanumi/pages/detail/widgets/detail_background.dart';
import 'package:nanumi/pages/detail/widgets/detail_content.dart';
import 'package:nanumi/pages/dashboard/widgets/dashboard_appbar_button.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)!.settings.arguments as DetailArgument;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DashboardAppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: DashboardAppBarButton(),
      ),
      body: Stack(
        children: [
          DetailBackground(organization: argument.organization),
          DetailContent(
            organization: argument.organization,
          ),
        ],
      ),
    );
  }
}
