import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/home/widgets/home_tabbar_view.dart';
import 'package:nanumi/pages/home/widgets/home_tabbar.dart';
import 'package:nanumi/widgets/dashboard_appbar.dart';
import 'package:nanumi/widgets/logo.dart';
import 'package:unicons/unicons.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 3,
    );
    _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(
        title: Logo(),
        action: [
          InkWell(
            onTap: () {},
            customBorder: CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(UniconsLine.cog),
            ),
          ),
        ],
        bottom: HomeTabBar(
          tabController: _tabController,
          pageController: _pageController,
        ),
      ),
      body: HomeTabBarView(
        tabController: _tabController,
        pageController: _pageController,
      ),
    );
  }
}
