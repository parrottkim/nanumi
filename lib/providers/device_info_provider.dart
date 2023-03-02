import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:nanumi/services/constants.dart';

final deviceInfoProvider =
    StateNotifierProvider<DeviceInfoNotifier, List<String>>(
        (ref) => DeviceInfoNotifier());

class DeviceInfoNotifier extends StateNotifier<List<String>> {
  DeviceInfoNotifier() : super([]) {
    _initializeInfo();
  }

  _initializeInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var info = await deviceInfo.deviceInfo;
    String udid = await FlutterUdid.consistentUdid;

    state = [
      Platform.isIOS
          ? info.data['name']
          : '${capitalize(info.data['brand'])} ${info.data['model']}',
      udid
    ];
  }
}
