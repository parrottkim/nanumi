import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingProvider =
    ChangeNotifierProvider<SettingNotifier>((ref) => SettingNotifier());

class SettingNotifier extends ChangeNotifier {
  final List<Map> list = [
    {
      'title': '기타',
      'items': [
        {
          'title': '의견 보내기',
          'route': '/setting/comment',
        },
      ],
    },
  ];
}
