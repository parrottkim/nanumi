import 'package:flutter/material.dart';
import 'package:nanumi/pages/detail/detail_page.dart';
import 'package:nanumi/pages/home/home_page.dart';
import 'package:nanumi/pages/organization/organization_page.dart';
import 'package:nanumi/pages/search/search_page.dart';
import 'package:nanumi/pages/setting/components/inquiry/inquiry_page.dart';
import 'package:nanumi/pages/setting/setting_page.dart';

final routes = {
  '/': (BuildContext context) => const HomePage(),
  '/organization': (BuildContext context) => const OrganizationPage(),
  '/detail': (BuildContext context) => const DetailPage(),
  '/search': (BuildContext context) => const SearchPage(),
  '/setting': (BuildContext context) => const SettingPage(),
  '/setting/comment': (BuildContext context) => const InquiryPage(),
};
