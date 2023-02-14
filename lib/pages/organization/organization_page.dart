import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/organization/controller/list_controller.dart';
import 'package:nanumi/pages/organization/widgets/organization_error.dart';
import 'package:nanumi/pages/organization/widgets/organization_filter.dart';
import 'package:nanumi/pages/organization/widgets/organization_list_item.dart';
import 'package:nanumi/pages/organization/widgets/organization_shimmer.dart';
import 'package:nanumi/widgets/default_progress_indicator.dart';
import 'package:unicons/unicons.dart';

class OrganizationPage extends ConsumerStatefulWidget {
  const OrganizationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrganizationPageState();
}

class _OrganizationPageState extends ConsumerState<OrganizationPage>
    with AutomaticKeepAliveClientMixin<OrganizationPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(listProvider);
    final totalCount = ref.watch(organizationTotalCountProvider);

    return RefreshIndicator(
      onRefresh: () async => ref.watch(listProvider.notifier).refresh(),
      child: NotificationListener<ScrollNotification>(
        child: LayoutBuilder(
          builder: (context, constraints) => ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: SingleChildScrollView(
              child: async.when(
                data: (data) => Column(
                  children: [
                    SizedBox(height: 8.0),
                    OrganizationFilter(),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: data.length < totalCount
                          ? data.length + 1
                          : data.length,
                      itemBuilder: (context, index) => index != data.length
                          ? OrganizationListItem(
                              organization: data[index],
                            )
                          : DefaultProgressIndicator(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.0),
                    ),
                  ],
                ),
                error: (error, stackTrace) => OrganizationError(error: error),
                loading: () => OrganizationShimmer(),
              ),
            ),
          ),
        ),
        onNotification: (notification) {
          if (notification.metrics.extentBefore ==
              notification.metrics.maxScrollExtent) {
            ref.watch(listProvider.notifier).fetchFirestoreData();
          }
          return false;
        },
      ),
    );
  }
}
