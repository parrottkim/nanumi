import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nanumi/pages/home/controller/home_controller.dart';
import 'package:nanumi/pages/home/widgets/home_list.dart';
import 'package:nanumi/pages/home/widgets/home_tabbar.dart';
import 'package:nanumi/widgets/dashboard_appbar.dart';
import 'package:nanumi/widgets/logo.dart';

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
    final stream = ref.watch(allOrganizationProvider);
    return Scaffold(
      appBar: DashboardAppBar(
        title: Logo(),
        action: [
          InkWell(
            onTap: () {},
            customBorder: CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(FontAwesomeIcons.magnifyingGlass),
            ),
          ),
          SizedBox(width: 4.0),
        ],
        bottom: HomeTabBar(
          tabController: _tabController,
          pageController: _pageController,
        ),
      ),
      body: Center(
        child: stream.when(
          data: (data) => HomeList(organizations: data),
          error: (error, stackTrace) {
            print(error);
            return Icon(Icons.error);
          },
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}
