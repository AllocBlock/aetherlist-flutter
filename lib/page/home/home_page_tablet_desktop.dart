import 'package:aetherlist_flutter/page/home/home_content.dart';
import 'package:aetherlist_flutter/widgets/navigation_drawer/navigation_drawer_tablet_desktop.dart';
import 'package:flutter/material.dart';

final key = GlobalKey<NavigationDrawerTabletDesktopState>();

class HomePageTabletDesktop extends StatelessWidget {
  const HomePageTabletDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationDrawerTabletDesktop(key: key),
          Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.menu, size: 40),
                        tooltip: 'Menu button',
                        onPressed: () {
                          key.currentState.toggleDrawer();
                        },
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Icon(
                          Icons.line_weight,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, size: 40),
                        tooltip: 'Add Button',
                        onPressed: () => Navigator.pushNamed(context, '/add'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: HomeContent(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
