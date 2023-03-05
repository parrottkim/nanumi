import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/home/controller/home_controller.dart';
import 'package:nanumi/pages/home/widgets/recent_list_item_list.dart';
import 'package:nanumi/pages/home/widgets/recent_no_element.dart';
import 'package:nanumi/pages/home/widgets/recent_shimmer.dart';

class RecentList extends ConsumerWidget {
  const RecentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recentProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '최근 의견',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 12.0),
          state.when(
            data: (data) => data.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) =>
                        RecentListItem(item: data[index]),
                    separatorBuilder: (context, index) => SizedBox(height: 8.0),
                  )
                : RecentNoElement(),
            loading: () => RecentShimmer(),
            error: (error, stackTrace) => SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
