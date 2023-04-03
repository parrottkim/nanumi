import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdMobService {
  static String get bannerAdUnitId {
    if (kReleaseMode) {
      if (Platform.isIOS) {
        return dotenv.env['IOS_AD']!;
      } else {
        return dotenv.env['ANDROID_AD']!;
      }
    } else {
      if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2934735716';
      } else {
        return 'ca-app-pub-3940256099942544/6300978111';
      }
    }
  }
}
