import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/pages/detail/controller/detail_controller.dart';
import 'package:nanumi/pages/detail/widgets/comment_list_item.dart';
import 'package:nanumi/pages/detail/widgets/comment_no_element.dart';
import 'package:nanumi/pages/detail/widgets/comment_shimmer.dart';
import 'package:nanumi/pages/organization/controller/organization_controller.dart';
import 'package:nanumi/widgets/default_progress_indicator.dart';

class CommentDialog extends ConsumerWidget {
  const CommentDialog({
    super.key,
    required this.organization,
  });

  final Organization organization;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(commentListProvider(organization.id));
    final notifier = ref.watch(commentListProvider(organization.id).notifier);

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
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 6.0),
            Text('부적절하거나 불쾌감을 줄 수 있는 의견은 통보없이 삭제될 수 있습니다.'),
            SizedBox(height: 12.0),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => notifier.refresh(),
                child: async.when(
                  data: (data) => data.isNotEmpty
                      ? Material(
                          child: ListView.separated(
                            controller: notifier.controller,
                            itemCount: data.length < notifier.totalCount
                                ? data.length + 1
                                : data.length,
                            itemBuilder: (context, index) =>
                                index != data.length
                                    ? CommentListItem(comment: data[index])
                                    : DefaultProgressIndicator(),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16.0),
                          ),
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
