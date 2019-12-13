import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/l10n/localization_intl.dart';
import 'package:aetherlist_flutter/models/category.dart';
import 'package:aetherlist_flutter/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FutureViewPage extends StatefulWidget {
  @override
  _FutureViewPageState createState() => _FutureViewPageState();
}

class _FutureViewPageState extends State<FutureViewPage> {
  final DateTime nowDate = DateTime.now();
  Category _selectCategory;

  @override
  Widget build(BuildContext context) {
    var localeText = CustomLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        titleName: localeText.futureView,
        actionChildren: <Widget>[
          PopupMenuButton(
            tooltip: "Menu",
            icon: Icon(Icons.more_vert),
            offset: Offset(0, 50),
            padding: EdgeInsets.symmetric(horizontal: 8),
            color: Colors.grey[100],
            itemBuilder: (context) {
              return <PopupMenuItem>[
                PopupMenuItem(
                  child: Text("Manage categories"),
                  value: 1,
                ),
              ];
            },
            onSelected: (result) {
              switch (result) {
                case 1:
                  Navigator.pushNamed(context, '/future/manage-categories');
                  break;
              }
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: Text("Please select a category"),
              disabledHint: Text("No avaliable category"),
              value: _selectCategory,
              items: Provider.of<AllItemsModel>(context)
                  .categories
                  .map<DropdownMenuItem<Category>>((Category category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.category_name),
                );
              }).toList(),
              onChanged: (Category newCategory) {
                setState(() {
                  _selectCategory = newCategory;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: 8.0, end: 8.0),
            height: 1.0,
            color: Colors.grey.shade300,
          ),
          Consumer<AllItemsModel>(
              builder: (BuildContext context, itemModel, Widget child) {
            return Expanded(
              child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (itemModel.items[index].parseDate().isAfter(
                            DateTime(nowDate.year, nowDate.month, nowDate.day)
                                .subtract(Duration(milliseconds: 1))) &&
                        _selectCategory != null &&
                        itemModel.items[index].category_id ==
                            _selectCategory.id) {
                      return ListTile(
                        title: Text(
                          itemModel.items[index].item_name,
                          style: TextStyle(
                            decoration: itemModel.items[index].finished
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: Text(itemModel.items[index].due_date),
                        onTap: () {},
                      );
                    } else {
                      return Container();
                    }
                  },
                  itemCount: itemModel.items.length),
            );
          }),
        ],
      ),
    );
  }
}
