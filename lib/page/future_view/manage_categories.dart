import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/l10n/localization_intl.dart';
import 'package:aetherlist_flutter/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageCategoriesPage extends StatefulWidget {
  @override
  _ManageCategoriesPageState createState() => _ManageCategoriesPageState();
}

class _ManageCategoriesPageState extends State<ManageCategoriesPage> {
  TextEditingController _addNameController = TextEditingController();
  TextEditingController _updateNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var localeText = CustomLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        titleName: "Manage categories",
        actionChildren: <Widget>[
          IconButton(
            icon: Icon(Icons.library_add),
            tooltip: "Add category",
            onPressed: () {
              showDialog(
                  context: context,
                  child: AlertDialog(
                    contentPadding: EdgeInsets.all(16),
                    content: TextFormField(
                      controller: _addNameController,
                      autofocus: true,
                      decoration:
                          InputDecoration(labelText: "New category name"),
                      validator: (value) {
                        return value.trim().length > 0
                            ? null
                            : 'Category name cannot be empty';
                      },
                    ),
                    actions: <Widget>[
                      FlatButton(
                          child: Text(localeText.cancel),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      FlatButton(
                          child: Text(localeText.yes),
                          onPressed: () {
                            Provider.of<AllItemsModel>(context)
                                .addCategory(_addNameController.text)
                                .then((succeed) {
                              if (succeed) {
                                _addNameController.clear();
                                Navigator.pop(context);
                              } else {
                                BotToast.showText(text: "add category failed");
                              }
                            });
                          })
                    ],
                  ));
            },
          ),
        ],
      ),
      body: Consumer<AllItemsModel>(
          builder: (BuildContext context, itemModel, Widget child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.edit),
                    tooltip: 'edit',
                    onPressed: () {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            contentPadding: EdgeInsets.all(24),
                            content: TextFormField(
                              controller: _updateNameController,
                              autofocus: true,
                              initialValue:
                                  itemModel.categories[index].category_name,
                              decoration: InputDecoration(
                                  labelText: "Update category name"),
                              validator: (value) {
                                return value.trim().length > 0
                                    ? null
                                    : 'Category name cannot be empty';
                              },
                            ),
                            actions: <Widget>[
                              FlatButton(
                                  child: Text(localeText.cancel),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              FlatButton(
                                  child: Text(localeText.yes),
                                  onPressed: () {
                                    Provider.of<AllItemsModel>(context)
                                        .updateCategory(
                                            itemModel.categories[index],
                                            _updateNameController.text)
                                        .then((succeed) {
                                      if (succeed) {
                                        _updateNameController.clear();
                                        Navigator.pop(context);
                                      } else {
                                        BotToast.showText(
                                            text: "update category failed");
                                      }
                                    });
                                  }),
                            ],
                          ));
                    },
                  ),
                  title: Text(
                    itemModel.categories[index].category_name,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    tooltip: 'delete',
                    onPressed: () {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            contentPadding: EdgeInsets.all(24),
                            content: Text(
                              "You really want to remove this category?",
                              textAlign: TextAlign.center,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                  child: Text(localeText.no),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              FlatButton(
                                  child: Text(localeText.yes),
                                  onPressed: () {
                                    Provider.of<AllItemsModel>(context)
                                        .removeCategory(
                                            itemModel.categories[index])
                                        .then((succeed) {
                                      if (succeed) {
                                        Navigator.pop(context);
                                      } else {
                                        BotToast.showText(
                                            text: "remove category failed");
                                      }
                                    });
                                  }),
                            ],
                          ));
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsetsDirectional.only(start: 8.0, end: 8.0),
                  height: 1.0,
                  color: Colors.grey.shade300,
                );
              },
              itemCount: itemModel.categories?.length ?? 0),
        );
      }),
    );
  }
}
