import 'package:flutter/material.dart';
import 'package:nanumi/pages/detail/detail_page.dart';
import 'package:nanumi/pages/home/home_page.dart';

final routes = {
  '/': (BuildContext context) => const HomePage(),
  '/detail': (BuildContext context) => const DetailPage(),
};
