import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/organization/controller/organization_controller.dart';
import 'package:nanumi/providers/theme_provider.dart';
import 'package:shimmer/shimmer.dart';

class OrganizationFilter extends ConsumerWidget {
  const OrganizationFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filterProvider);
    final notifier = ref.watch(filterProvider.notifier);

    final textColor = Theme.of(context).primaryColor;
    final backgroundColor = Theme.of(context).colorScheme.outline;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          SizedBox(
            height: 31.0,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: notifier.filter.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  ref.invalidate(listProvider);
                  notifier.value = index;
                },
                borderRadius: BorderRadius.circular(20.0),
                child: Ink(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      width: 2.0,
                      color: backgroundColor,
                    ),
                    color:
                        state == index ? backgroundColor : Colors.transparent,
                  ),
                  child: Text(
                    notifier.filter[index]['text'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: state == index ? textColor : backgroundColor,
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(width: 4.0),
            ),
          ),
          Spacer(),
          if (ref.watch(listProvider).value == null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: SizedBox(
                width: 55.0,
                height: 17.0,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.2),
                  highlightColor: Colors.grey.withOpacity(0.1),
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (ref.watch(listProvider).value != null)
            Text(
              '전체 ${ref.watch(listProvider).value!.length}건',
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
    );
  }
}
