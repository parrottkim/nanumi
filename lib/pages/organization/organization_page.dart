import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/organization/controller/organization_controller.dart';
import 'package:nanumi/pages/organization/widgets/organization_error.dart';
import 'package:nanumi/pages/organization/widgets/organization_filter.dart';
import 'package:nanumi/pages/organization/widgets/organization_list_item.dart';
import 'package:nanumi/pages/organization/widgets/organization_shimmer.dart';
import 'package:nanumi/providers/device_info_provider.dart';
import 'package:nanumi/widgets/default_appbar.dart';
import 'package:nanumi/widgets/default_icon_button.dart';
import 'package:nanumi/widgets/default_progress_indicator.dart';

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
    super.build(context);
    ref.watch(deviceInfoProvider);
    final async = ref.watch(listProvider);
    final notifier = ref.watch(listProvider.notifier);

    return Scaffold(
      appBar: DefaultAppBar(
        elevation: 0.0,
        centerTitle: true,
        leading: DefaultIconButton(),
        title: Text(
          '단체 목록',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: SingleChildScrollView(
            controller: notifier.controller,
            child: Column(
              children: [
                SizedBox(height: 8.0),
                OrganizationFilter(),
                async.when(
                  data: (data) => ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: data.length < notifier.totalCount
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
                  error: (error, stackTrace) => OrganizationError(error: error),
                  loading: () => OrganizationShimmer(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
