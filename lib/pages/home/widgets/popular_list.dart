import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/home/controller/home_controller.dart';
import 'package:nanumi/pages/home/widgets/popular_list_item.dart';
import 'package:nanumi/pages/home/widgets/popular_no_element.dart';
import 'package:nanumi/pages/home/widgets/popular_shimmer.dart';

class PopularList extends ConsumerWidget {
  const PopularList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(popularProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 8.0),
          child: Row(
            children: [
              Text(
                '인기 단체',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Spacer(),
              InkWell(
                borderRadius: BorderRadius.circular(8.0),
                onTap: () => Navigator.pushNamed(context, '/organization'),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    '더보기',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        state.when(
          data: (data) => data.isNotEmpty
              ? SizedBox(
                  height: 108.0,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: data.length,
                    itemBuilder: (context, index) =>
                        PopularListItem(item: data[index]),
                    separatorBuilder: (context, index) => SizedBox(width: 8.0),
                  ),
                )
              : PopularNoElement(),
          loading: () => PopularShimmer(),
          error: (error, stackTrace) => SizedBox.shrink(),
        ),
      ],
    );
  }
}
