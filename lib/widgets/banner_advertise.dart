import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nanumi/constants/ad_mob_service.dart';

class BannerAdvertise extends StatelessWidget {
  const BannerAdvertise({
    Key? key,
    this.padding = EdgeInsets.zero,
    this.width,
    this.height,
  }) : super(key: key);

  final EdgeInsets padding;
  final double? width;
  final double? height;

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
        },
      ),
    )..load();

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        padding: padding,
        width: width ?? banner.size.width.toDouble(),
        height: height ?? banner.size.height.toDouble(),
        child: AdWidget(
          ad: banner,
        ),
      ),
    );
  }
}
