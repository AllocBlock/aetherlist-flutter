import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/l10n/localization_intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationDrawerContent extends StatelessWidget {
  const NavigationDrawerContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localText = CustomLocalizations.of(context);

    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel userModel, Widget child) {
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
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/login');
                            },
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.blueGrey,
                                  child: Icon(Icons.person),
                                  radius: 40,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  userModel.isLogin
                                      ? userModel.user.user_name
                                      : localText.login,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text(localText.categories),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.equalizer),
              title: Text(localText.statistics),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text(localText.archives),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(localText.settings),
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
            if (userModel.isLogin)
              ListTile(
                leading: const Icon(Icons.power_settings_new),
                title: Text(localText.logout),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(localText.logoutTip),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(localText.cancel),
                              onPressed: () => Navigator.pop(context),
                            ),
                            FlatButton(
                              child: Text(localText.yes),
                              onPressed: () {
                                userModel.user = null;
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                },
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
//                  Center(child: Text('Test')),
//                ],
//              ),
//            ),
//          ),
//        ),
          ],
        );
      },
    );
  }
}
