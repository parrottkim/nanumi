import 'package:flutter/material.dart';
import 'package:nanumi/pages/search/widgets/search_tabbar.dart';
import 'package:nanumi/pages/search/widgets/search_tabbar_view.dart';
import 'package:nanumi/widgets/default_appbar.dart';
import 'package:nanumi/widgets/default_icon_button.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 2,
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
    final argument = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: DefaultAppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              '검색결과',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            Text(
              argument,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        leading: DefaultIconButton(),
        bottom: SearchTabBar(
          text: argument,
          tabController: _tabController,
          pageController: _pageController,
        ),
      ),
      body: SearchTabBarView(
        text: argument,
        tabController: _tabController,
        pageController: _pageController,
      ),
    );
  }
}
