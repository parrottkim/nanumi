import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/pages/search_overlay/widgets/result_list_item.dart';
import 'package:nanumi/pages/search_overlay/widgets/result_no_element.dart';

class ResultList extends ConsumerWidget {
  const ResultList({
    Key? key,
    required this.result,
  }) : super(key: key);

  final List<Organization> result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: result.length,
      itemBuilder: (context, index) => result.isNotEmpty
          ? ResultListItem(item: result[index])
          : Text('abcd'),
    );
  }
}
