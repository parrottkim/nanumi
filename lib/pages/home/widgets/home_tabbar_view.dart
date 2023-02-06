import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/home/controller/home_controller.dart';

class HomeTabBarView extends ConsumerWidget {
  const HomeTabBarView({
    Key? key,
    required this.tabController,
    required this.pageController,
  }) : super(key: key);

  final TabController tabController;
  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(tabBarProvider.notifier);

    return PageView(
      controller: pageController,
      onPageChanged: (value) {
        notifier.value = value;
        tabController.animateTo(value,
            duration: Duration(milliseconds: 200), curve: Curves.ease);
      },
      children: notifier.pages,
    );
  }
}
