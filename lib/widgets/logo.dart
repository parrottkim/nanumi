import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSecondary,
          width: 2.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/logo_colored.svg',
            width: 24.0,
            height: 24.0,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 4.0),
          Text(
            'nanumi',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
