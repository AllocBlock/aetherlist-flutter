import 'package:aetherlist_flutter/page/about/about.dart';
import 'package:aetherlist_flutter/page/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:aetherlist_flutter/page/home/home_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/settings': (context) => SettingPage(),
        '/about': (context) => AboutPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        primaryColor: Colors.white,
        cardColor: Colors.lightBlue[200],
        toggleableActiveColor: Colors.lightBlue[100],
      ),
    );
  }
}
