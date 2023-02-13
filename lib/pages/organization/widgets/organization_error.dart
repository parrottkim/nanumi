import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class OrganizationError extends StatelessWidget {
  const OrganizationError({
    Key? key,
    required this.error,
  }) : super(key: key);

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 4),
        Icon(
          UniconsLine.sad_dizzy,
          size: 64.0,
        ),
        SizedBox(height: 16.0),
        Text(
          '아이고 이런!\n데이터를 가져오지 못했습니다',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }
}
