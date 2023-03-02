import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class CommentNoElement extends StatelessWidget {
  const CommentNoElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 3),
        Icon(
          UniconsLine.comment_question,
          size: 64.0,
        ),
        SizedBox(height: 16.0),
        Text(
          '아직 작성된 의견이 없습니다',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
          ),
        )
      ],
    );
  }
}
