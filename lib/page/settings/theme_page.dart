import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeModel>(context);
    return Scaffold(
      appBar: CustomAppBar(
        titleName: "Theme",
        actionChildren: <Widget>[],
      ),
      body: ListView(
        children: Global.themes.map<Widget>((e) {
          return ListTile(
            title: Container(
              color: e,
              height: 50,
              width: 200,
            ),
            trailing: theme.theme == e ? Icon(Icons.done) : null,
            onTap: () {
              theme.theme = e;
            },
          );
        }).toList(),
      ),
    );
  }
}
