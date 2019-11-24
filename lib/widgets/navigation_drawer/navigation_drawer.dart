import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:aetherlist_flutter/widgets/navigation_drawer/navigation_drawer_mobile.dart';
import 'package:aetherlist_flutter/widgets/navigation_drawer/navigation_drawer_tablet_desktop.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NavigationDrawerMobile(),
      tablet: NavigationDrawerTabletDesktop(),
      desktop: NavigationDrawerTabletDesktop(),
    );
  }
}
