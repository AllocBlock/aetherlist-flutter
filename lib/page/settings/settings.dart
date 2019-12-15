import 'package:aetherlist_flutter/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:aetherlist_flutter/l10n/localization_intl.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localText = CustomLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        titleName: localText.settings,
        actionChildren: <Widget>[],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text(localText.theme),
            onTap: () => Navigator.pushNamed(context, '/settings/theme'),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(localText.languages),
            onTap: () => Navigator.pushNamed(context, '/settings/language'),
          ),
        ],
      ),
    );
  }
}
