import 'package:flutter/material.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/pages/detail/argument/detail_argument.dart';
import 'package:nanumi/pages/organization/widgets/area_section.dart';
import 'package:nanumi/pages/organization/widgets/domain_section.dart';
import 'package:unicons/unicons.dart';

class PopularListItem extends StatelessWidget {
  const PopularListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Organization item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.0),
      onTap: () => Navigator.pushNamed(
        context,
        '/detail',
        arguments: DetailArgument(organization: item),
      ),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
        width: MediaQuery.of(context).size.width / 1.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 0.0,
              blurRadius: 2.0,
              offset: Offset(0, 3),
            ),
          ],
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(
                      UniconsLine.thumbs_up,
                      size: 16.0,
                    ),
                    SizedBox(width: 4.0),
                    Text('${item.likes}'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 6.0),
            DomainSection(
              organization: item,
              isShrink: true,
            ),
            SizedBox(height: 6.0),
            AreaSection(
              organization: item,
              isShrink: true,
            ),
          ],
        ),
      ),
    );
  }
}
