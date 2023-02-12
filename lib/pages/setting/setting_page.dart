import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:nanumi/constants/constants.dart';
import 'package:nanumi/pages/dashboard/widgets/dashboard_appbar.dart';
import 'package:nanumi/pages/dashboard/widgets/dashboard_appbar_button.dart';
import 'package:unicons/unicons.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DashboardAppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          '설정',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24.0,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        leading: DashboardAppBarButton(
          showShadow: false,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).viewPadding.top +
                  AppBar().preferredSize.height),
          FutureBuilder<Map<String, dynamic>>(
              future: getDeviceInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    color: Theme.of(context).shadowColor,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline,
                              width: 2.0,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(
                              UniconsLine.mobile_android,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${snapshot.data!['name']}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              '${snapshot.data!['identifierForVendor'].substring(0, 7)}',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              })
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   child: Text(
          //     '설정',
          //     style: TextStyle(
          //       fontWeight: FontWeight.w700,
          //       fontSize: 24.0,
          //       color: Theme.of(context).colorScheme.outline,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
