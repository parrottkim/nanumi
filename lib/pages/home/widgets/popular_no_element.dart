import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class PopularNoElement extends StatelessWidget {
  const PopularNoElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108.0,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            UniconsLine.annoyed,
            size: 40.0,
          ),
          SizedBox(height: 8.0),
          Text(
            '아직 좋아요를 누른 단체가 없습니다',
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
