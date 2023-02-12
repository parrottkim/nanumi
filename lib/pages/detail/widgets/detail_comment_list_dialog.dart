import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/pages/detail/controller/detail_controller.dart';
import 'package:nanumi/pages/detail/widgets/detail_comment_list_item.dart';
import 'package:unicons/unicons.dart';

class DetailCommentListDialog extends ConsumerWidget {
  const DetailCommentListDialog({
    Key? key,
    required this.organization,
  }) : super(key: key);

  final Organization organization;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commentListProvider(organization.id));
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
            SizedBox(height: 12.0),
            Expanded(
              child: ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) =>
                    DetailCommentListItem(comment: state[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
