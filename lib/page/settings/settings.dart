import 'package:aetherlist_flutter/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleName: 'Settings',
        showSearchIcon: false,
      ),
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
