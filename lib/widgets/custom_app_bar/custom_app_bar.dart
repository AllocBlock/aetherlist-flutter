import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String titleName;
  final bool showSearchIcon;
  const CustomAppBar({Key key, this.titleName, this.showSearchIcon})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(48.0);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AppBar(
          title: Text(
            widget.titleName,
            textScaleFactor: 0.96,
          ),
          elevation: 0.0,
          actions: <Widget>[
            widget.showSearchIcon
                ? IconButton(
                    icon: Icon(Icons.search),
                    onPressed: !widget.showSearchIcon ? null : () {},
                  )
                : Container(),
          ],
        )
      ],
    );
  }
}
