import 'package:aetherlist_flutter/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:aetherlist_flutter/l10n/localization_intl.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localeText = CustomLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        titleName: localeText.about,
        actionChildren: <Widget>[],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 100,
              child: Icon(
                Icons.line_weight,
                size: 100,
              ),
            ),
            Text(
              'AetherList',
              textScaleFactor: 1.5,
              style: TextStyle(height: 1.5),
            ),
            Text(
              'Version: 0.0.1',
              textScaleFactor: 0.75,
              style: TextStyle(color: Colors.grey),
            ),
            Divider(
              height: 40,
            ),
            Text(
              'A flexible todo list.',
              textScaleFactor: 1,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
