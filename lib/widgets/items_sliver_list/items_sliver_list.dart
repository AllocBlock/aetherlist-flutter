import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class ItemsSliverList extends StatefulWidget {
  final dynamic itemModel;
  const ItemsSliverList({Key key, @required this.itemModel}) : super(key: key);

  @override
  _ItemsSliverListState createState() => _ItemsSliverListState();
}

class _ItemsSliverListState extends State<ItemsSliverList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableSliverList(
      delegate: ReorderableSliverChildListDelegate(
          List.generate(widget.itemModel.items?.length ?? 0, (index) {
        return Dismissible(
          key: Key('${widget.itemModel.items[index].id}'),
          background: _finishCard,
          secondaryBackground: _archiveCard,
          onDismissed: (direction) {
            final Item tempItem = widget.itemModel.items[index];
            String action;
            if (direction == DismissDirection.startToEnd) {
              action = 'finished';
              widget.itemModel.toggleFinishItem(index);
            } else {
              action = 'archived';
              widget.itemModel.removeItem(index);
            }
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${tempItem.item_name} $action!'),
                action: SnackBarAction(
                  label: 'Undo',
                  textColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      if (action == 'finished') {
                        widget.itemModel.toggleFinishItem(index);
                      } else {
                        widget.itemModel.insertItem(tempItem);
                      }
                    });
                  },
                ),
              ),
            );
          },
          child: Opacity(
            opacity: (widget.itemModel.items.length * 1.25 - index) /
                (widget.itemModel.items.length * 1.25),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              margin: EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: widget.itemModel.items[index].finished,
                    onChanged: (value) {
                      setState(() {
                        // FIXME: index has been changed, undo is invalid
                        widget.itemModel.toggleFinishItem(index);
                      });
                    },
                  ),
                  Text(
                    widget.itemModel.items[index].item_name,
                    style: TextStyle(
                      decoration: widget.itemModel.items[index].finished
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      })),
      onReorder: widget.itemModel.updateItemsIndex,
    );
  }

  static final Card _finishCard = Card(
    child: Container(
      height: 10.0,
      color: Colors.green,
      padding: EdgeInsets.all(10.0),
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        children: <Widget>[
          Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Finish',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  );

  static final Card _archiveCard = Card(
    child: Container(
      color: Colors.amber,
      padding: EdgeInsets.all(10.0),
      alignment: AlignmentDirectional.centerEnd,
      child: Row(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Icon(Icons.archive),
          SizedBox(
            width: 10,
          ),
          Text(
            'Archive',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    ),
  );
}
