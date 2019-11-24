import 'package:aetherlist_flutter/widgets/navigation_drawer/navigation_drawer_content.dart';
import 'package:flutter/material.dart';

class NavigationDrawerTabletDesktop extends StatefulWidget {
  NavigationDrawerTabletDesktop({Key key}) : super(key: key);

  @override
  NavigationDrawerTabletDesktopState createState() =>
      NavigationDrawerTabletDesktopState();
}

class NavigationDrawerTabletDesktopState
    extends State<NavigationDrawerTabletDesktop> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();
  }

  toggleDrawer() => setState(() {
        _visible = !_visible;
      });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: _visible ? 1.0 : 0.0,
      child: Visibility(
        visible: _visible,
        child: Container(
          width: 250.0,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              blurRadius: 16,
              color: Colors.black12,
            )
          ]),
          child: NavigationDrawerContent(),
        ),
      ),
    );
  }
}
