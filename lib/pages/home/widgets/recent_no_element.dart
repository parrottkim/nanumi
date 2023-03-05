import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class RecentNoElement extends StatelessWidget {
  const RecentNoElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            UniconsLine.annoyed,
            size: 40.0,
          ),
          SizedBox(height: 8.0),
          Text(
            '아직 작성된 의견이 없습니다\n먼저 의견을 작성해보세요!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
