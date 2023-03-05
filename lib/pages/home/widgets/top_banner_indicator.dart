import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/home/controller/home_controller.dart';

class TopBannerIndicator extends ConsumerWidget {
  const TopBannerIndicator({
    super.key,
    required this.length,
  });

  final int length;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bannerIndexProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.black.withOpacity(0.7),
      ),
      child: Text(
        '${state + 1} / ${length}',
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
