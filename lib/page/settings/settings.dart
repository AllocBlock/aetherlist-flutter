import 'package:aetherlist_flutter/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleName: 'Settings',
        actionChildren: <Widget>[],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text('Theme'),
            onTap: () => Navigator.pushNamed(context, '/settings/theme'),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('Language'),
            onTap: () => Navigator.pushNamed(context, '/settings/language'),
          ),
        ],
      ),
    );
  }
}
