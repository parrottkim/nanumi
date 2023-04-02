import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/search/controller/search_controller.dart';
import 'package:nanumi/pages/search/widgets/area_list.dart';
import 'package:nanumi/pages/search/widgets/domain_list.dart';

class SearchTabBarView extends ConsumerWidget {
  const SearchTabBarView({
    Key? key,
    required this.text,
    required this.tabController,
    required this.pageController,
  }) : super(key: key);

  final String text;
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
      children: [
        DomainList(text: text),
        AreaList(text: text),
      ],
    );
  }
}
