import 'package:flutter/material.dart';

class NavigationDrawerContent extends StatelessWidget {
  const NavigationDrawerContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 150,
          child: DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        child: Icon(Icons.person),
                        radius: 40,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text('username'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.category),
                title: Text('Categories'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.equalizer),
                title: Text('Statistics'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.archive),
                title: Text('Archives'),
                onTap: () {},
            ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.of(context).pushNamed('/settings');
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {
                  Navigator.of(context).pushNamed('/about');
                },
              ),
            ],
          ),
        ),
        // TODO: add today progress indicator
//        Align(
//          alignment: FractionalOffset.bottomCenter,
//          child: Padding(
//            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
//            child: SizedBox(
//              height: 100.0,
//              child: Stack(
//                children: <Widget>[
//                  Center(
//                    child: Container(
//                      width: 100,
//                      height: 100,
//                      child: CircularProgressIndicator(
//                        valueColor:
//                            AlwaysStoppedAnimation<Color>(Colors.blueGrey),
//                        strokeWidth: 5,
//                        value: null,
//                      ),
//                    ),
//                  ),
//                  Center(child: Text("Test")),
//                ],
//              ),
//            ),
//          ),
//        ),
      ],
    );
  }
}
