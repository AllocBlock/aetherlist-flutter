import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/l10n/localization_intl.dart';
import 'package:aetherlist_flutter/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localeText = CustomLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        titleName: localeText.statistics,
        actionChildren: <Widget>[],
      ),
      body: Consumer<AllItemsModel>(
          builder: (BuildContext context, itemModel, Widget child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: IconButton(
                    icon: itemModel.historyItems[index].finished
                        ? Icon(Icons.check_box)
                        : Icon(Icons.check_box_outline_blank),
                    onPressed: () {},
                  ),
                  title: Text(
                    itemModel.historyItems[index].item_name,
                    style: TextStyle(
                      decoration: itemModel.historyItems[index].finished
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Text(itemModel.historyItems[index].due_date),
                  onTap: () {},
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsetsDirectional.only(start: 8.0, end: 8.0),
                  height: 1.0,
                  color: Colors.grey.shade300,
                );
              },
              itemCount: itemModel.historyItems?.length ?? 0),
        );
      }),
    );
  }
}
