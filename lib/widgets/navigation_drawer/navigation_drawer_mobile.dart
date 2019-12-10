import 'package:aetherlist_flutter/widgets/navigation_drawer/navigation_drawer_content.dart';
import 'package:flutter/material.dart';

class NavigationDrawerMobile extends StatelessWidget {
  const NavigationDrawerMobile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          blurRadius: 16,
          color: Colors.black12,
        )
      ]),
      child: NavigationDrawerContent(isMobile: true,),
    );
  }
}
