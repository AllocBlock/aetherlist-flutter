import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/page/about/about.dart';
import 'package:aetherlist_flutter/page/add/add_page.dart';
import 'package:aetherlist_flutter/page/home/home_page.dart';
import 'package:aetherlist_flutter/page/profile/login.dart';
import 'package:aetherlist_flutter/page/settings/settings.dart';
import 'package:flutter/material.dart';

void main() => Global.init().then((e) => runApp(App()));

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/settings': (context) => SettingPage(),
        '/about': (context) => AboutPage(),
        '/add': (context) => AddPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        brightness: Brightness.light,
        primaryColor: Colors.grey[50],
        cardColor: Colors.lightBlue[200],
        toggleableActiveColor: Colors.lightBlue[100],
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ),
    );
  }
}
