import 'package:flutter/material.dart';

class RecentComment extends StatelessWidget {
  const RecentComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      ],
    );
  }
}
