import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/detail/controller/detail_controller.dart';

class ReportDialog extends ConsumerWidget {
  const ReportDialog({
    Key? key,
    required this.organizationId,
    required this.commentId,
  }) : super(key: key);

  final String organizationId;
  final String commentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.watch(reportProvider);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      insetPadding: EdgeInsets.all(16.0),
      contentPadding: EdgeInsets.zero,
      content: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                splashRadius: 18.0,
                icon: Icon(Icons.close),
              ),
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '의견 신고하기',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 18.0),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        '신고 사유를 선택해주세요.\n신고된 내용은 검수를 거쳐 처리됩니다.',
                      ),
                      SizedBox(height: 6.0),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: report.list.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () async {
                      await report.reportComment(
                          organizationId, commentId, index);
                      _showDialog(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 16.0),
                      child: Text(
                        report.list[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => Divider(
                    color: Theme.of(context).dividerColor,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showDialog(BuildContext context) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        insetPadding: EdgeInsets.all(16.0),
        contentPadding: EdgeInsets.zero,
        content: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => Navigator.pop(_),
                  splashRadius: 18.0,
                  icon: Icon(Icons.close),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '의견 신고하기',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 18.0),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    '신고가 접수되었습니다.\n검토까지 최대 24시간이 소요됩니다.',
                  ),
                  SizedBox(height: 6.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
