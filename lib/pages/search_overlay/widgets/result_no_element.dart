import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class ResultNoElement extends StatelessWidget {
  const ResultNoElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          UniconsLine.annoyed,
          size: 30.0,
        ),
        SizedBox(height: 8.0),
        Text(
          '결과가 없습니다',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
