import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nanumi/contants/ad_unit_id.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TargetPlatform os = Theme.of(context).platform;

    BannerAd banner = BannerAd(
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {},
        onAdLoaded: (_) {},
      ),
      size: AdSize.banner,
      adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
      request: AdRequest(),
    )..load();

    return Center(
      child: AdWidget(
        ad: banner,
      ),
    );
  }
}
