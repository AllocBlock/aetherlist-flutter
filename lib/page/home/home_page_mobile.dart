import 'package:aetherlist_flutter/page/home/home_content.dart';
import 'package:flutter/material.dart';
import 'package:aetherlist_flutter/widgets/navigation_drawer/navigation_drawer.dart';

class HomePageMobile extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HomePageMobile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawer(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu, size: 30),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.line_weight,
                    color: Colors.grey,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, size: 30),
                  onPressed: () => Navigator.pushNamed(context, '/add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: HomeContent(),
            ),
          )
        ],
      ),
    );
  }
}
