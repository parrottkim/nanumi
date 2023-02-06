import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/comment/comment_page.dart';
import 'package:nanumi/pages/list/list_page.dart';
import 'package:nanumi/pages/search/search_page.dart';

final tabBarProvider =
    StateNotifierProvider<TabBarNotifier, int>((ref) => TabBarNotifier());

class TabBarNotifier extends StateNotifier<int> {
  TabBarNotifier() : super(0);

  final List<Widget> _pages = [
    ListPage(),
    CommentPage(),
    SearchPage(),
  ];
  List<Widget> get pages => _pages;

  set value(int index) => state = index;
}
