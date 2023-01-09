import 'package:flutter/material.dart';

class HubiaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool trasnparent;
  final String? title;

  const HubiaAppBar({Key? key, this.trasnparent = false, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: trasnparent ? Colors.transparent : null,
      elevation: trasnparent ? 0 : null,
      leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          color: trasnparent ? Colors.grey.shade400 : Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).canPop()
              ? Navigator.of(context).pop()
              : Navigator.of(context, rootNavigator: true).pop();
        },
      ),
      title: Text(
        this.title ?? "",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
