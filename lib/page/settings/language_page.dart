import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/l10n/localization_intl.dart';
import 'package:aetherlist_flutter/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    var localeModel = Provider.of<LocaleModel>(context);
    var localText = CustomLocalizations.of(context);
    Widget _buildLanguageItem(String language, value) {
      return ListTile(
        title: Text(
          language,
          style: TextStyle(color: localeModel.locale == value ? color : null),
        ),
        trailing: localeModel.locale == value ? Icon(Icons.done, color: color,) : null,
        onTap: () {
          localeModel.locale = value;
        },
      );
    }
    return Scaffold(
      appBar: CustomAppBar(
        titleName: "Language",
        actionChildren: <Widget>[],
      ),
      body: ListView(
        children: <Widget>[
          _buildLanguageItem("简体中文", "zh_CN"),
          _buildLanguageItem("English", "en_US"),
          _buildLanguageItem("Auto", null),
        ],
      ),
    );
  }
}
