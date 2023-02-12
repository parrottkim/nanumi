import 'package:flutter/material.dart';
import 'package:nanumi/pages/detail/detail_page.dart';
import 'package:nanumi/pages/dashboard/dashboard_page.dart';
import 'package:nanumi/pages/setting/setting_page.dart';

final routes = {
  '/': (BuildContext context) => const DashboardPage(),
  '/detail': (BuildContext context) => const DetailPage(),
  '/setting': (BuildContext context) => const SettingPage(),
};
