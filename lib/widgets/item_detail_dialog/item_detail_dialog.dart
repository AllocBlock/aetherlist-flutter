import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/flutter_hack_widgets/custom_dialog.dart'
    as customDialog;
import 'package:aetherlist_flutter/l10n/localization_intl.dart';
import 'package:aetherlist_flutter/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDetailDialog extends StatelessWidget {
  final Item item;
  const ItemDetailDialog({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localeText = CustomLocalizations.of(context);
    return customDialog.Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: Container(
        margin: EdgeInsets.only(left: 0.0, right: 0.0),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 12.0),
              margin: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 16.0,
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Item details",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Expanded(
                    child: Theme(
                      data: ThemeData(
                          textTheme: TextTheme(
                        subhead: TextStyle(fontSize: 12.0, color: Colors.grey),
                        caption:
                            TextStyle(fontSize: 18.0, color: Colors.black87),
                      )),
                      child: ListView(shrinkWrap: true, children: <Widget>[
                        ListTile(
                          title: Text("Item title"),
                          subtitle: Text(item.item_name),
                        ),
                        ListTile(
                          title: Text('Category'),
                          subtitle: Text(Provider.of<AllItemsModel>(context)
                              .categories
                              .firstWhere((e) => e.id == item.category_id)
                              .category_name),
                        ),
                        ListTile(
                          title: Text('Priority'),
                          subtitle: Slider(
                            min: 0.01,
                            max: 0.99,
                            value: item.priority,
                            onChanged: null,
                          ),
                        ),
                        ListTile(
                          title: Text('Tags'),
                          subtitle: Text(item.tags.join(", ")),
                        ),
                        ListTile(
                          title: Text("Time-range mode",
                              style: TextStyle(
                                decoration: item.enable_time_range
                                    ? TextDecoration.none
                                    : TextDecoration.lineThrough,
                              )),
                        ),
                        ListTile(
                          title: Text("Due date"),
                          subtitle: Text(item.due_date),
                        ),
                        ListTile(
                          title: Text('Notification',
                              style: TextStyle(
                                decoration: item.enable_notification
                                    ? TextDecoration.none
                                    : TextDecoration.lineThrough,
                              )),
                        ),
                        if (item.enable_notification)
                          ListTile(
                            title: Text("Notify time"),
                            subtitle: Text(item.notify_time),
                          )
                        else
                          Container(),
                        ListTile(
                          title: Text('Location'),
                          subtitle: Text(item.location),
                        ),
                        ListTile(
                          title: Text('Description'),
                          subtitle: Text(item.description),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/edit', arguments: item);
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 21.0,
                    backgroundColor: Theme.of(context).primaryColorLight,
                    child: Icon(
                      Icons.edit,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CircleAvatar(
                    radius: 21.0,
                    backgroundColor: Colors.red[400],
                    child: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
