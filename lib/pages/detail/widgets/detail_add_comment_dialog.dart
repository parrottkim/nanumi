import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nanumi/constants/constants.dart';
import 'package:nanumi/models/comment.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/pages/detail/controller/detail_controller.dart';
import 'package:unicons/unicons.dart';

class DetailAddCommentDialog extends ConsumerStatefulWidget {
  const DetailAddCommentDialog({
    Key? key,
    required this.organization,
    required this.device,
    required this.deviceId,
  });

  final Organization organization;
  final String device;
  final String deviceId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailAddCommentDialogState();
}

class _DetailAddCommentDialogState
    extends ConsumerState<DetailAddCommentDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(commentProvider.notifier);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      insetPadding: EdgeInsets.all(30.0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '의견 남기기',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 6.0),
            Text('한 기기당 한 개의 의견만 남길 수 있습니다.\n중복으로 작성된 경우에는 기존 의견이 삭제됩니다.'),
            SizedBox(height: 6.0),
            Row(
              children: [
                Icon(UniconsLine.mobile_android, size: 20.0),
                SizedBox(width: 4.0),
                Text(
                  '${widget.device} | ${widget.deviceId.substring(0, 4)}****',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                ),
              ],
            ),
            TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 4,
              onChanged: (value) => notifier.value = value,
            ),
            SizedBox(height: 6.0),
            InkWell(
              onTap: () => ref.watch(agreementProvider.notifier).value =
                  !ref.watch(agreementProvider),
              borderRadius: BorderRadius.circular(20.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Ink(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ref.watch(agreementProvider)
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).cardColor,
                      ),
                      child: Icon(
                        UniconsLine.check,
                        size: 12.0,
                        color: ref.watch(agreementProvider)
                            ? Theme.of(context).cardColor
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text('모바일 고유식별번호 수집을 동의합니다'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 6.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '취소',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                InkWell(
                  onTap: ref.watch(commentProvider).isNotEmpty &&
                          ref.watch(agreementProvider)
                      ? () async {
                          ref.watch(addCommentProvider(Comment(
                            id: widget.organization.id,
                            device: widget.device,
                            deviceId: widget.deviceId,
                            text: ref.watch(commentProvider),
                            date: DateTime.now(),
                          )).future);
                          Navigator.pop(context);
                        }
                      : null,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '완료',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: ref.watch(commentProvider).isNotEmpty &&
                                ref.watch(agreementProvider)
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[400],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
