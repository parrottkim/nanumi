import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nanumi/constants/constants.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/pages/detail/widgets/detail_add_comment_dialog.dart';
import 'package:nanumi/pages/detail/widgets/detail_comment_list_dialog.dart';
import 'package:nanumi/pages/organization/widgets/area_section.dart';
import 'package:nanumi/pages/organization/widgets/domain_section.dart';
import 'package:nanumi/widgets/banner_advertise.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailContent extends StatelessWidget {
  const DetailContent({
    Key? key,
    required this.organization,
  }) : super(key: key);

  final Organization organization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3.5 + 20.0,
          ),
          Text(
            organization.name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24.0,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          DomainSection(organization: organization),
          SizedBox(height: 12.0),
          AreaSection(organization: organization),
          SizedBox(height: 16.0),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 8,
            child: BannerAdvertise(),
          ),
          SizedBox(height: 16.0),
          InkWell(
            onTap: () => launchUrl(
              Uri.parse(organization.website),
            ),
            child: Ink(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
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
              child: Row(
                children: [
                  Icon(UniconsLine.link),
                  SizedBox(width: 8.0),
                  Text(
                    '홈페이지 방문',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.0),
          InkWell(
            onTap: () async {
              final info = await getDeviceInfo();
              final device = Platform.isIOS ? info['name'] : info['model'];
              final deviceId =
                  Platform.isIOS ? info['identifierForVendor'] : info['id'];
              return showDialog(
                context: context,
                builder: (_) => DetailAddCommentDialog(
                  organization: organization,
                  device: device,
                  deviceId: deviceId,
                ),
              );
            },
            child: Ink(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
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
              child: Row(
                children: [
                  Icon(UniconsLine.thumbs_up),
                  SizedBox(width: 8.0),
                  Text(
                    '의견 남기기',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.0),
          InkWell(
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => DetailCommentListDialog(
                organization: organization,
              ),
            ),
            child: Ink(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
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
              child: Row(
                children: [
                  Icon(UniconsLine.comment_alt_message),
                  SizedBox(width: 8.0),
                  Text(
                    '의견 보기',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.0),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '정보 수정 요청',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
