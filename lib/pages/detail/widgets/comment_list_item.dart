import 'package:flutter/material.dart';
import 'package:nanumi/constants/constants.dart';
import 'package:nanumi/models/comment.dart';
import 'package:unicons/unicons.dart';

class CommentListItem extends StatelessWidget {
  const CommentListItem({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
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
            Row(
              children: [
                Icon(UniconsLine.mobile_android, size: 20.0),
                SizedBox(width: 4.0),
                Text(
                  '${comment.device} | ${comment.deviceId.substring(0, 4)}****',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              comment.text,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                height: 1.0,
                color: Theme.of(context).dividerColor,
              ),
            ),
            Text(
              getDetailDate(comment.createdAt),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
