import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class SearchNoElement extends StatelessWidget {
  const SearchNoElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 3),
        Icon(
          UniconsLine.question_circle,
          size: 40.0,
        ),
        SizedBox(height: 8.0),
        Text(
          '검색 결과가 없습니다',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
          ),
        )
      ],
    );
  }
}
