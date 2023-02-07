import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nanumi/constants/ad_mob_service.dart';

class BannerAdvertise extends StatelessWidget {
  const BannerAdvertise({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BannerAd banner = BannerAd(
      adUnitId: AdMobService.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {},
        onAdFailedToLoad: (banner, error) {
          banner.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    )..load();

    return SizedBox(
      width: banner.size.width.toDouble(),
      height: banner.size.height.toDouble(),
      child: AdWidget(
        ad: banner,
      ),
    );
  }
}
