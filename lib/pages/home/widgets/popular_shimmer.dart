import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PopularShimmer extends StatelessWidget {
  const PopularShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108.0,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) => ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.7,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.2),
              highlightColor: Colors.grey.withOpacity(0.1),
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(width: 8.0),
      ),
    );
  }
}
