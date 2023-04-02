import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/organization/widgets/organization_error.dart';
import 'package:nanumi/pages/organization/widgets/organization_list_item.dart';
import 'package:nanumi/pages/organization/widgets/organization_shimmer.dart';
import 'package:nanumi/pages/search/controller/search_controller.dart';
import 'package:nanumi/pages/search/widgets/search_no_element.dart';
import 'package:nanumi/widgets/default_progress_indicator.dart';

class DomainList extends ConsumerWidget {
  const DomainList({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(domainProvider(text));
    final notifier = ref.watch(domainProvider(text).notifier);

    return state.when(
      data: (data) => data.isNotEmpty
          ? ListView.separated(
              shrinkWrap: true,
              controller: notifier.controller,
              padding: EdgeInsets.all(16.0),
              itemCount: data.length < notifier.totalCount
                  ? data.length + 1
                  : data.length,
              itemBuilder: (context, index) => index != data.length
                  ? OrganizationListItem(
                      organization: data[index],
                    )
                  : DefaultProgressIndicator(),
              separatorBuilder: (context, index) => SizedBox(height: 16.0),
            )
          : SearchNoElement(),
      error: (error, stackTrace) => OrganizationError(error: error),
      loading: () => OrganizationShimmer(),
    );
  }
}
