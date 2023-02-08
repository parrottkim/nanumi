import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight(
            (toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  DashboardAppBar({
    Key? key,
    this.centerTitle = false,
    this.title,
    this.leading,
    this.action,
    this.bottom,
    this.backgroundColor = Colors.white,
    this.brightness = Brightness.light,
    this.toolbarHeight = 56.0,
  }) : preferredSize =
            _PreferredAppBarSize(toolbarHeight, bottom?.preferredSize.height);

  final bool? centerTitle;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? action;
  final PreferredSizeWidget? bottom;
  final Color backgroundColor;
  final Brightness brightness;
  final double toolbarHeight;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      leading: leading,
      title: title,
      actions: action != null
          ? [
              ...action!,
              SizedBox(width: 8.0),
            ]
          : null,
      bottom: bottom,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: brightness,
      ),
    );
  }
}
