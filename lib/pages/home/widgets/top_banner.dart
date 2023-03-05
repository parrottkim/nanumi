import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/home/controller/home_controller.dart';
import 'package:nanumi/pages/home/widgets/top_banner_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class TopBanner extends ConsumerWidget {
  const TopBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bannerProvider);
    return state.when(
      data: (data) => Stack(
        alignment: Alignment.topRight,
        children: [
          CarouselSlider.builder(
            itemCount: data.length,
            itemBuilder: (context, index, realIndex) => Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: data[index]['image'],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(0.2),
                    highlightColor: Colors.grey.withOpacity(0.1),
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.white.withOpacity(0.2),
                    onTap: () => launchUrl(
                      Uri.parse(data[index]['link']),
                    ),
                  ),
                ),
              ],
            ),
            options: CarouselOptions(
              enableInfiniteScroll: data.length > 1 ? true : false,
              autoPlay: true,
              animateToClosest: false,
              aspectRatio: 2 / 1,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) =>
                  ref.watch(bannerIndexProvider.notifier).value = index,
            ),
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: TopBannerIndicator(length: data.length),
          ),
        ],
      ),
      error: (error, stackTrace) => SizedBox.shrink(),
      loading: () => SizedBox.shrink(),
    );
  }
}
