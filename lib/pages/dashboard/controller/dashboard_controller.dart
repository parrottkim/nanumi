import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/home/home_page.dart';
import 'package:nanumi/pages/organization/organization_page.dart';
import 'package:nanumi/pages/search/search_page.dart';

final tabBarProvider =
    StateNotifierProvider<TabBarNotifier, int>((ref) => TabBarNotifier());

class TabBarNotifier extends StateNotifier<int> {
  TabBarNotifier() : super(0);

  final List<Widget> _pages = [
    HomePage(),
    OrganizationPage(),
    SearchPage(),
  ];
  List<Widget> get pages => _pages;

  final List<Widget> _tabs = [
    Tab(text: '홈'),
    Tab(text: '단체 목록'),
    Tab(text: '찾아보기'),
  ];
  List<Widget> get tabs => _tabs;

  set value(int index) => state = index;
}
