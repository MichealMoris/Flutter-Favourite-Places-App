import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? action;
  const MainAppBar({
    super.key,
    required this.title,
    this.action,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: action,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
