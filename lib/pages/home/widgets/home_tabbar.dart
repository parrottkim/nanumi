import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTabBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const HomeTabBar({
    super.key,
    required this.tabController,
    required this.pageController,
  });

  final TabController tabController;
  final PageController pageController;

  @override
  Size get preferredSize => Size.fromHeight(44.0);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeTabBarState();
}

class _HomeTabBarState extends ConsumerState<HomeTabBar> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.tabController,
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
          color: Theme.of(context).colorScheme.secondary,
        ),
        insets: EdgeInsets.symmetric(horizontal: 50.0),
      ),
      tabs: [
        Tab(text: '전체'),
        Tab(text: '지역'),
        Tab(text: '사업'),
      ],
    );
  }
}
