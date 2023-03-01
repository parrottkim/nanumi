import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/providers/device_info_provider.dart';
import 'package:nanumi/widgets/default_appbar.dart';
import 'package:nanumi/widgets/default_icon_button.dart';
import 'package:unicons/unicons.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final device = ref.watch(deviceInfoProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
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
      body: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).viewPadding.top +
                  AppBar().preferredSize.height),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            color: Theme.of(context).shadowColor,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 2.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(
                      UniconsLine.mobile_android,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device[0],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      '${device[1].substring(0, 4)}****',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
