import 'dart:io';

import 'package:flutter/foundation.dart';

class AdMobService {
  static String get bannerAdUnitId {
    if (kReleaseMode) {
      if (Platform.isIOS) {
        return 'ca-app-pub-7969001949780433/7414688061';
      } else {
        return 'ca-app-pub-7969001949780433/8807660789';
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
