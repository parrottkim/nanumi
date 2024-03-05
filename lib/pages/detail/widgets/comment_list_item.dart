import 'package:flutter/material.dart';
import 'package:nanumi/models/comment.dart';
import 'package:nanumi/pages/detail/widgets/report_dialog.dart';
import 'package:nanumi/services/constants.dart';
import 'package:unicons/unicons.dart';

class CommentListItem extends StatelessWidget {
  const CommentListItem({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            spreadRadius: 0.0,
            blurRadius: 2.0,
            offset: Offset(0, 3),
          ),
        ],
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(UniconsLine.mobile_android, size: 20.0),
                SizedBox(width: 4.0),
                Text(
                  '${comment.device} | ${comment.deviceId.substring(0, 4)}****',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                ),
                Spacer(),
                Text(
                  getDetailDate(comment.createdAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              comment.text,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Divider(
              height: 1.0,
              color: Theme.of(context).dividerColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(16.0),
              onTap: () => showDialog(
                context: context,
                builder: (_) => ReportDialog(
                  organizationId: comment.organizationId,
                  commentId: comment.id!,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  '이 의견 신고하기',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
