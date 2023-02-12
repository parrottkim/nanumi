import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class DashboardAppBarButton extends StatelessWidget {
  const DashboardAppBarButton({
    Key? key,
    this.onPressed,
    this.showShadow = true,
    this.icon = const Icon(UniconsLine.angle_left),
  }) : super(key: key);

  final Function()? onPressed;
  final bool showShadow;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48.0,
      height: 48.0,
      child: InkWell(
        onTap: onPressed ?? () => Navigator.maybePop(context),
        borderRadius: showShadow
            ? BorderRadius.circular(16.0)
            : BorderRadius.circular(40.0),
        child: Ink(
          padding: const EdgeInsets.all(8.0),
          decoration: showShadow
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      spreadRadius: 0.0,
                      blurRadius: 2.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Theme.of(context).cardColor,
                )
              : null,
          child: icon,
        ),
      ),
    );
  }
}
