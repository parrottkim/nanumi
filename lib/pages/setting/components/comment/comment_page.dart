import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/setting/components/comment/controller/comment_controller.dart';
import 'package:nanumi/providers/device_info_provider.dart';
import 'package:nanumi/widgets/default_appbar.dart';
import 'package:nanumi/widgets/default_icon_button.dart';
import 'package:unicons/unicons.dart';

class CommentPage extends ConsumerStatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends ConsumerState<CommentPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final device = ref.watch(deviceInfoProvider);
    final notifier = ref.watch(commentProvider.notifier);

    return Scaffold(
      appBar: DefaultAppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          '의견 보내기',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        leading: DefaultIconButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '도움이 필요하신가요?\n운영자에게 의견을 보내주세요.',
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Icon(UniconsLine.mobile_android, size: 20.0),
                      SizedBox(width: 4.0),
                      Text(
                        '${device[0]} | ${device[1].substring(0, 4)}****',
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
            Spacer(),
            MaterialButton(
              onPressed: ref.watch(commentProvider).isNotEmpty &&
                      ref.watch(agreementProvider)
                  ? () async {
                      var commnet = {
                        'device': device[0],
                        'deviceId': device[1],
                        'text': ref.watch(commentProvider),
                        'createdAt': DateTime.now()
                      };
                      await ref.watch(addCommentProvider(commnet).future);
                      Navigator.pop(context);
                    }
                  : null,
              color: Theme.of(context).colorScheme.primary,
              disabledColor: Theme.of(context).cardColor,
              minWidth: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                '완료',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
