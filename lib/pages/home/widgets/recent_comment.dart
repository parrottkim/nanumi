import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/home/controller/home_controller.dart';

class RecentComment extends ConsumerWidget {
  const RecentComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recentCommentProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                '최근 의견',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Spacer(),
              InkWell(
                onTap: () => Navigator.pushNamed(context, '/organization'),
                child: Text(
                  '더 보기',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
        state.when(
          data: (data) => ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) => Text(
                '${data[index].comment.id} ${data[index].organization.id}'),
          ),
          loading: () => SizedBox.shrink(),
          error: (error, stackTrace) => SizedBox.shrink(),
        ),
      ],
    );
  }
}
