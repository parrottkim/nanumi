import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nanumi/services/ad_mob_service.dart';
import 'package:shimmer/shimmer.dart';

class InlineAdvertise extends StatefulWidget {
  InlineAdvertise({
    Key? key,
    this.insets = 16.0,
  }) : super(key: key);

  final double insets;

  @override
  State<InlineAdvertise> createState() => _InlineAdvertiseState();
}

class _InlineAdvertiseState extends State<InlineAdvertise> {
  AdManagerBannerAd? _inlineAdaptiveAd;
  bool _isLoaded = false;
  AdSize? _adSize;
  late Orientation _currentOrientation;

  double get _adWidth =>
      MediaQuery.of(context).size.width - (2 * widget.insets);

  double get _adHeight =>
      (MediaQuery.of(context).size.width - (2 * widget.insets)) * 0.3125;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentOrientation = MediaQuery.of(context).orientation;
    _loadAd();
  }

  void _loadAd() async {
    await _inlineAdaptiveAd?.dispose();
    setState(() {
      _inlineAdaptiveAd = null;
      _isLoaded = false;
    });

    AdSize size = AdSize.getInlineAdaptiveBannerAdSize(
      _adWidth.truncate(),
      _adHeight.truncate(),
    );

    _inlineAdaptiveAd = AdManagerBannerAd(
      adUnitId: AdMobService.bannerAdUnitId,
      sizes: Platform.isIOS ? [size] : [AdSize.fluid, size],
      request: AdManagerAdRequest(),
      listener: AdManagerBannerAdListener(
        onAdLoaded: (Ad ad) async {
          AdManagerBannerAd bannerAd = (ad as AdManagerBannerAd);
          final AdSize? size = await bannerAd.getPlatformAdSize();
          if (size == null) {
            return;
          }

          setState(() {
            _inlineAdaptiveAd = bannerAd;
            _isLoaded = true;
            _adSize = size;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Inline adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    await _inlineAdaptiveAd!.load();
  }

  Widget _getAdWidget() {
    return Align(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (_currentOrientation == orientation &&
                _inlineAdaptiveAd != null &&
                _isLoaded &&
                _adSize != null) {
              return SizedBox(
                width: _adWidth,
                height: _adHeight,
                child: AdWidget(
                  ad: _inlineAdaptiveAd!,
                ),
              );
            }
            if (_currentOrientation != orientation) {
              _currentOrientation = orientation;
              _loadAd();
            }
            return SizedBox(
              width: _adWidth,
              height: _adHeight,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.1),
                highlightColor: Colors.grey.withOpacity(0.05),
                child: Container(
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getAdWidget();
  }

  @override
  void dispose() {
    super.dispose();
    _inlineAdaptiveAd?.dispose();
  }
}
