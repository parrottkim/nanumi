import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/home/controller/home_controller.dart';
import 'package:nanumi/pages/home/widgets/recent_comment_list_item.dart';

class RecentComment extends ConsumerWidget {
  const RecentComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recentCommentProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '최근 반응',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 12.0),
          state.when(
            data: (data) => ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) =>
                  RecentCommentListItem(item: data[index]),
              separatorBuilder: (context, index) => SizedBox(height: 8.0),
            ),
            loading: () => SizedBox.shrink(),
            error: (error, stackTrace) => SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
