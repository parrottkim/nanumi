import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/home/widgets/home_appbar.dart';
import 'package:nanumi/pages/home/widgets/popular_list.dart';
import 'package:nanumi/pages/home/widgets/recent_list.dart';
import 'package:nanumi/pages/search_overlay/search_overlay.dart';
import 'package:nanumi/pages/home/widgets/top_banner.dart';
import 'package:nanumi/providers/device_info_provider.dart';
import 'package:nanumi/widgets/inline_advertise.dart';
import 'package:nanumi/widgets/default_icon_button.dart';
import 'package:nanumi/widgets/logo.dart';
import 'package:unicons/unicons.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(deviceInfoProvider);
    return Scaffold(
      appBar: HomeAppBar(
        elevation: 0.0,
        title: Logo(),
        action: [
          SearchOverlay(),
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
            TopBanner(),
            SizedBox(height: 20.0),
            InlineAdvertise(),
            SizedBox(height: 20.0),
            PopularList(),
            SizedBox(height: 20.0),
            RecentList(),
          ],
        ),
      ),
    );
  }
}
