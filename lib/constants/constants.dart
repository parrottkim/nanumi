import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<Map<String, dynamic>> getDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  var info = await deviceInfo.deviceInfo;
  return info.data;
}
