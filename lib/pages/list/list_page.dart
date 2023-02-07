import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/list/controller/list_controller.dart';
import 'package:nanumi/pages/list/widgets/organization_list_item.dart';
import 'package:nanumi/widgets/default_progress_indicator.dart';
import 'package:unicons/unicons.dart';

class ListPage extends ConsumerStatefulWidget {
  const ListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListPageState();
}

class _ListPageState extends ConsumerState<ListPage>
    with AutomaticKeepAliveClientMixin<ListPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(listProvider);
    final allCount = ref.watch(allCountProvider);

    return RefreshIndicator(
      onRefresh: () async => ref.watch(listProvider.notifier).refresh(),
      child: NotificationListener<ScrollNotification>(
        child: LayoutBuilder(
          builder: (context, constraints) => ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: ListView.separated(
              padding: EdgeInsets.all(16.0),
              itemCount:
                  state.length < allCount ? state.length + 1 : state.length,
              itemBuilder: (context, index) => index != state.length
                  ? OrganizationListItem(
                      organization: state[index],
                    )
                  : DefaultProgressIndicator(),
              separatorBuilder: (context, index) => SizedBox(height: 16.0),
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
