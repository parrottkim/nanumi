import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/dashboard/controller/dashboard_controller.dart';

class DashboardTabBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const DashboardTabBar({
    super.key,
    required this.tabController,
    required this.pageController,
  });

  final TabController tabController;
  final PageController pageController;

  @override
  Size get preferredSize => Size.fromHeight(44.0);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardTabBarState();
}

class _DashboardTabBarState extends ConsumerState<DashboardTabBar> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(tabBarProvider.notifier);

    return TabBar(
      controller: widget.tabController,
      onTap: (value) {
        notifier.value = value;
        widget.pageController.animateToPage(value,
            duration: Duration(milliseconds: 200), curve: Curves.ease);
      },
      labelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16.0,
      ),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2,
          color: Theme.of(context).colorScheme.outline,
        ),
        insets: EdgeInsets.symmetric(horizontal: 44.0),
      ),
      tabs: notifier.tabs,
    );
  }
}
