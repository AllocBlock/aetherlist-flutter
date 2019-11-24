import 'package:aetherlist_flutter/page/about/about.dart';
import 'package:aetherlist_flutter/page/profile/login.dart';
import 'package:aetherlist_flutter/page/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:aetherlist_flutter/page/home/home_page.dart';

void main() => runApp(App());

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
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        brightness: Brightness.light,
        primaryColor: Colors.white,
        cardColor: Colors.lightBlue[200],
        toggleableActiveColor: Colors.lightBlue[100],
        inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
          labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ),
    );
  }
}
