import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nanumi/models/comment.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/pages/detail/controller/detail_controller.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

class AddCommentDialog extends ConsumerStatefulWidget {
  const AddCommentDialog({
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
      _AddCommentDialogState();
}

class _AddCommentDialogState extends ConsumerState<AddCommentDialog> {
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
          Column(
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
                      '의견 남기기',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 18.0),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      '한 기기당 한 개의 의견만 남길 수 있습니다.\n중복으로 작성된 경우에는 기존 의견이 삭제됩니다.',
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        Icon(UniconsLine.mobile_android, size: 20.0),
                        SizedBox(width: 4.0),
                        Text(
                          '${widget.device} | ${widget.deviceId.substring(0, 4)}****',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.outline),
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: InkWell(
                  onTap: () => ref.watch(agreementProvider.notifier).value =
                      !ref.watch(agreementProvider),
                  borderRadius: BorderRadius.circular(20.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 4.0),
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
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '개인정보처리방침',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => launchUrl(
                                        Uri.parse(
                                            'https://sites.google.com/view/nanumi/%ED%99%88'),
                                      ),
                              ),
                              TextSpan(
                                text: '에 동의합니다',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6.0),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: ref.watch(commentProvider).isNotEmpty &&
                            ref.watch(agreementProvider)
                        ? () async {
                            var commnet = Comment(
                              organizationId: widget.organization.id,
                              device: widget.device,
                              deviceId: widget.deviceId,
                              text: ref.watch(commentProvider),
                              createdAt: DateTime.now(),
                            );
                            await ref.watch(addCommentProvider(commnet).future);
                            Navigator.pop(context);
                          }
                        : null,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ],
      ),
    );
  }
}
