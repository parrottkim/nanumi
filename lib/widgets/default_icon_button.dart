import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class DefaultIconButton extends StatelessWidget {
  const DefaultIconButton({
    Key? key,
    this.onPressed,
    this.icon = const Icon(UniconsLine.angle_left),
  }) : super(key: key);

  final Function()? onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => Navigator.maybePop(context),
      splashRadius: 24.0,
      icon: icon,
    );
  }
}
