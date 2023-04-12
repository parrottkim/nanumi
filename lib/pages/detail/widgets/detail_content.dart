import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/pages/animations/bounce_animation.dart';
import 'package:nanumi/pages/detail/controller/detail_controller.dart';
import 'package:nanumi/pages/detail/widgets/comment_dialog.dart';
import 'package:nanumi/pages/detail/widgets/add_comment_dialog.dart';
import 'package:nanumi/pages/organization/controller/organization_controller.dart';
import 'package:nanumi/pages/organization/widgets/area_section.dart';
import 'package:nanumi/pages/organization/widgets/domain_section.dart';
import 'package:nanumi/providers/device_info_provider.dart';
import 'package:nanumi/widgets/inline_advertise.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailContent extends ConsumerWidget {
  const DetailContent({
    Key? key,
    required this.organization,
  }) : super(key: key);

  final Organization organization;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(deviceInfoProvider);
    final liked = ref.watch(likedProvider(organization));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3.5 + 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  organization.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Theme.of(context).colorScheme.outline),
                ),
              ),
              SizedBox(width: 10.0),
              InkWell(
                borderRadius: BorderRadius.circular(16.0),
                onTap: () async {
                  ref.watch(bounceProvider.notifier).toggle();
                  await ref
                      .watch(likedProvider(organization).notifier)
                      .toggleLiked(liked);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Row(
                    children: [
                      BounceAnimation(
                        child: ref.watch(likedProvider(organization))
                            ? SvgPicture.asset(
                                'assets/icons/thumbs_up.svg',
                                width: 20.0,
                                color: Theme.of(context).colorScheme.outline,
                              )
                            : Icon(
                                UniconsLine.thumbs_up,
                                size: 20.0,
                              ),
                      ),
                      SizedBox(width: 4.0),
                      ref.watch(detailProvider(organization.id)).when(
                            data: (data) => Text(
                              '${ref.watch(detailProvider(organization.id)).value!.likes}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                            error: (error, stackTrace) => SizedBox.shrink(),
                            loading: () => SizedBox.shrink(),
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '대표 사업',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 12.0),
              DomainSection(organization: organization),
              SizedBox(height: 20.0),
              Text(
                '대표 사업국',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 12.0),
              AreaSection(organization: organization),
              // SizedBox(height: 16.0),
              // InlineAdvertise(),
              SizedBox(height: 16.0),
              if (organization.website.isNotEmpty)
                InkWell(
                  borderRadius: BorderRadius.circular(16.0),
                  onTap: () => launchUrl(
                    Uri.parse(organization.website),
                  ),
                  child: Ink(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 12.0),
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
              if (organization.website.isNotEmpty) SizedBox(height: 12.0),
              InkWell(
                borderRadius: BorderRadius.circular(16.0),
                onTap: () async {
                  return showDialog(
                    context: context,
                    builder: (_) => AddCommentDialog(
                      organization: organization,
                      device: info[0],
                      deviceId: info[1],
                    ),
                  );
                },
                child: Ink(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12.0),
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
                      Icon(UniconsLine.edit_alt),
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
                borderRadius: BorderRadius.circular(16.0),
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => CommentDialog(
                    organization: organization,
                  ),
                ),
                child: Ink(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12.0),
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
            ],
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 8.0),
        //   child: InkWell(
        //     borderRadius: BorderRadius.circular(8.0),
        //     onTap: () {},
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Text(
        //         '정보 수정 요청',
        //         style: Theme.of(context).textTheme.bodySmall?.copyWith(
        //               fontWeight: FontWeight.w700,
        //             ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
