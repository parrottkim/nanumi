import 'package:flutter/material.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/pages/detail/argument/detail_argument.dart';
import 'package:unicons/unicons.dart';

class ResultListItem extends StatelessWidget {
  const ResultListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Organization item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        '/detail',
        arguments: DetailArgument(organization: item),
      ),
      child: Ink(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Row(
            children: [
              Expanded(child: Text(item.name)),
              Row(
                children: [
                  Icon(
                    UniconsLine.thumbs_up,
                    size: 12.0,
                  ),
                  SizedBox(width: 4.0),
                  Text('${item.likes}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
