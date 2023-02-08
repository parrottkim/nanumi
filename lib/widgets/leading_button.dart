import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class LeadingButton extends StatelessWidget {
  const LeadingButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.maybePop(context),
      customBorder: CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(UniconsLine.angle_left),
      ),
    );
  }
}
