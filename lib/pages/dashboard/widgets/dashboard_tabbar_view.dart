import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/dashboard/controller/dashboard_controller.dart';
import 'package:nanumi/widgets/banner_advertise.dart';

class DashboardTabBarView extends ConsumerWidget {
  const DashboardTabBarView({
    Key? key,
    required this.tabController,
    required this.pageController,
  }) : super(key: key);

  final TabController tabController;
  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(tabBarProvider.notifier);

    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: pageController,
            onPageChanged: (value) {
              notifier.value = value;
              tabController.animateTo(value,
                  duration: Duration(milliseconds: 200), curve: Curves.ease);
            },
            children: notifier.pages,
          ),
        ),
        BannerAdvertise(),
      ],
    );
  }
}
