import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/pages/comment/controller/comment_controller.dart';
import 'package:nanumi/pages/comment/widgets/comment_list_item.dart';
import 'package:nanumi/pages/comment/widgets/comment_no_element.dart';
import 'package:nanumi/pages/comment/widgets/comment_shimmer.dart';
import 'package:nanumi/pages/organization/controller/list_controller.dart';
import 'package:nanumi/widgets/default_progress_indicator.dart';

class CommentPage extends ConsumerWidget {
  const CommentPage({
    super.key,
    required this.organization,
  });

  final Organization organization;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(commentListProvider(organization.id));
    final notifier = ref.watch(commentListProvider(organization.id).notifier);

    final totalCount = ref.watch(likeTotalCountProvider(organization.id));

    return Padding(
      padding: EdgeInsets.only(
          top: AppBar().preferredSize.height +
              MediaQuery.of(context).viewPadding.top),
      child: Container(
        padding: EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '의견 보기',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 6.0),
            Text('근거 없는 비방, 상업적 게시글 및 욕설은 통보없이 삭제될 수 있습니다.'),
            SizedBox(height: 12.0),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => notifier.refresh(),
                child: async.when(
                  data: (data) => data.isNotEmpty
                      ? NotificationListener<ScrollNotification>(
                          child: ListView.separated(
                            itemCount: data.length < totalCount
                                ? data.length + 1
                                : data.length,
                            itemBuilder: (context, index) =>
                                index != data.length
                                    ? CommentListItem(comment: data[index])
                                    : DefaultProgressIndicator(),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16.0),
                          ),
                          onNotification: (notification) {
                            if (notification.metrics.extentBefore ==
                                notification.metrics.maxScrollExtent) {
                              if (data.length >= 10) {
                                notifier.fetchFirestoreData();
                              }
                            }
                            return false;
                          },
                        )
                      : CommentNoElement(),
                  error: (error, stackTrace) => SizedBox(),
                  loading: () => CommentShimmer(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
