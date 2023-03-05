import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecentShimmer extends StatelessWidget {
  const RecentShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) => ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: SizedBox(
          height: 109.0,
          width: MediaQuery.of(context).size.width,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.2),
            highlightColor: Colors.grey.withOpacity(0.1),
            child: Container(
              color: Colors.white,
            ),
          ),
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(height: 8.0),
    );
  }
}
