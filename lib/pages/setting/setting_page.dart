import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/setting/widgets/setting_device.dart';
import 'package:nanumi/pages/setting/widgets/setting_list.dart';
import 'package:nanumi/widgets/default_appbar.dart';
import 'package:nanumi/widgets/default_icon_button.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: DefaultAppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          '설정',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        leading: DefaultIconButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingDevice(),
            SizedBox(height: 16.0),
            SettingList(),
          ],
        ),
      ),
    );
  }
}
