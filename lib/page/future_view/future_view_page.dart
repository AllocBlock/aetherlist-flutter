import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/l10n/localization_intl.dart';
import 'package:aetherlist_flutter/models/category.dart';
import 'package:aetherlist_flutter/models/item.dart';
import 'package:aetherlist_flutter/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:aetherlist_flutter/widgets/item_detail_dialog/item_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_widget/search_widget.dart';

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
                  child: Text(localeText.manageCategories),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Consumer<AllItemsModel>(
                builder: (BuildContext context, itemModel, Widget child) {
                  return SearchWidget<Item>(
                    dataList: itemModel.items,
                    hideSearchBoxWhenItemSelected: false,
                    listContainerHeight: MediaQuery.of(context).size.height / 4,
                    noItemsFoundWidget: NoItemsFound(),
                    queryBuilder: (String query, List<Item> list) {
                      if (query == "") {
                        return [];
                      } else {
                        return list
                            .where((Item item) =>
                        item.parseDate().isAfter(DateTime(
                            nowDate.year, nowDate.month, nowDate.day)
                            .subtract(Duration(milliseconds: 1))) &&
                            item.item_name
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                            .toList();
                      }
                    },
                    popupListItemBuilder: (Item item) {
                      return PopupListItemWidget(item);
                    },
                    selectedItemBuilder:
                        (Item selectedItem, VoidCallback deleteSelectedItem) {
                      return Container();
                    },
                    onItemSelected: (item) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            ItemDetailDialog(item: item),
                      );
                    },
                  );
                }),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text(localeText.selectCategoryValidation),
                disabledHint: Text(localeText.noValidCategory),
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
                              leading: IconButton(
                                icon: Icon(itemModel.items[index].finished
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank),
                                onPressed: () {
                                  setState(() {
                                    itemModel.items[index].finished =
                                    !itemModel.items[index].finished;
                                    itemModel.editItem(itemModel.items[index]);
                                  });
                                },
                              ),
                              title: Text(
                                itemModel.items[index].item_name,
                                style: TextStyle(
                                  decoration: itemModel.items[index].finished
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              subtitle: Text(itemModel.items[index].due_date),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      ItemDetailDialog(
                                          item: itemModel.items[index]),
                                );
                              },
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
      ),
    );
  }
}

class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        item.item_name,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.error_outline,
          size: 24,
          color: Colors.grey[900].withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          "No Items Found",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900].withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}