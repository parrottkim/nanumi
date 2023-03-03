import 'package:flutter/material.dart';
import 'package:nanumi/models/recent.dart';
import 'package:nanumi/services/constants.dart';
import 'package:unicons/unicons.dart';

class RecentCommentListItem extends StatelessWidget {
  const RecentCommentListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Recent item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.0),
      onTap: () {},
      child: Ink(
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
                  '${item.comment.device} | ${item.comment.deviceId.substring(0, 4)}****',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                ),
                Spacer(),
                Text(
                  getDetailDate(item.comment.createdAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              item.comment.text,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                height: 1.0,
                color: Theme.of(context).dividerColor,
              ),
            ),
            Text(
              item.organization.name,
            )
          ],
        ),
      ),
    );
  }
}
