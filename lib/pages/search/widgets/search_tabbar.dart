import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/search/controller/search_controller.dart';

class SearchTabBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const SearchTabBar({
    super.key,
    required this.text,
    required this.tabController,
    required this.pageController,
  });

  final String text;
  final TabController tabController;
  final PageController pageController;

  @override
  Size get preferredSize => Size.fromHeight(44.0);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchTabBarState();
}

class _SearchTabBarState extends ConsumerState<SearchTabBar> {
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
          color: Theme.of(context).colorScheme.primary,
        ),
        insets: EdgeInsets.symmetric(horizontal: 76.0),
      ),
      tabs: [
        Tab(
            text: ref.watch(nameProvider(widget.text)).value != null
                ? '단체 ${ref.watch(nameProvider(widget.text).notifier).totalCount}'
                : '단체'),
        Tab(
            text: ref.watch(areaProvider(widget.text)).value != null
                ? '사업국 ${ref.watch(areaProvider(widget.text).notifier).totalCount}'
                : '사업국'),
      ],
    );
  }
}
