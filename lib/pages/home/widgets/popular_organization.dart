import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/home/controller/home_controller.dart';
import 'package:nanumi/pages/home/widgets/popular_organization_list_item.dart';

class PopularOrganization extends ConsumerWidget {
  const PopularOrganization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(popularOrganizationProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 8.0),
          child: Row(
            children: [
              Text(
                '인기 단체',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Spacer(),
              InkWell(
                borderRadius: BorderRadius.circular(8.0),
                onTap: () => Navigator.pushNamed(context, '/organization'),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    '더보기',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        state.when(
          data: (data) => ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) =>
                PopularOrganizationListItem(item: data[index]),
            separatorBuilder: (context, index) => SizedBox(height: 8.0),
          ),
          loading: () => SizedBox.shrink(),
          error: (error, stackTrace) => SizedBox.shrink(),
        ),
      ],
    );
  }
}
