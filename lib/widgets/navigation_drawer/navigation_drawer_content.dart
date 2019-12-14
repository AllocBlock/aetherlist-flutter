import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/l10n/localization_intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationDrawerContent extends StatelessWidget {
  final bool isMobile;
  const NavigationDrawerContent({Key key, @required this.isMobile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localeText = CustomLocalizations.of(context);

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
                              if (!userModel.isLogin)
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
                                      : localeText.login,
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
              leading: Icon(Icons.clear_all),
              title: Text(localeText.futureView),
              onTap: () {
                if (isMobile) {
                  Navigator.pop(context);
                }
                Navigator.of(context).pushNamed('/future');
              },
            ),
            ListTile(
              leading: Icon(Icons.insert_chart),
              title: Text(localeText.statistics),
              onTap: () {
                if (isMobile) {
                  Navigator.pop(context);
                }
                Navigator.of(context).pushNamed('/statistics');
              },
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text(localeText.archives),
              onTap: () {
                if (isMobile) {
                  Navigator.pop(context);
                } else {}
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(localeText.settings),
              onTap: () {
                if (isMobile) {
                  Navigator.pop(context);
                }
                Navigator.of(context).pushNamed('/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(localeText.about),
              onTap: () {
                if (isMobile) {
                  Navigator.pop(context);
                }
                Navigator.of(context).pushNamed('/about');
              },
            ),
            if (userModel.isLogin)
              ListTile(
                leading: const Icon(Icons.power_settings_new),
                title: Text(localeText.logout),
                onTap: () {
                  if (isMobile) {
                    Navigator.pop(context);
                  }
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(localeText.logoutTip),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(localeText.cancel),
                              onPressed: () => Navigator.pop(context),
                            ),
                            FlatButton(
                              child: Text(localeText.yes),
                              onPressed: () {
                                userModel.user = null;
                                Global.profile.session = "";
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                },
              )
            else
              ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(localeText.login),
                  onTap: () {
                    if (isMobile) {
                      Navigator.pop(context);
                    }
                    Navigator.pushNamed(context, '/login');
                  }),
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
