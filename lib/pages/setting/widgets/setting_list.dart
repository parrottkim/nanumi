import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/setting/controller/setting_controller.dart';

class SettingList extends ConsumerWidget {
  const SettingList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(settingProvider).list;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              list[index]['title'],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          SettingSubList(items: list[index]['items']),
        ],
      ),
    );
  }
}

class SettingSubList extends StatelessWidget {
  const SettingSubList({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Map> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => Navigator.pushNamed(context, items[index]['route'],
            arguments: items[index]['route'] == ''),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            items[index]['title'],
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
