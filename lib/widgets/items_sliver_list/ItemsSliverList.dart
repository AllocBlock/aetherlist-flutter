import 'package:aetherlist_flutter/widgets/todo_item/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class ItemsSliverList extends StatefulWidget {
  final List<TodoItem> items;
  const ItemsSliverList({Key key, this.items}) : super(key: key);

  @override
  _ItemsSliverListState createState() => _ItemsSliverListState();
}

class _ItemsSliverListState extends State<ItemsSliverList> {
  @override
  void initState() {
    super.initState();
    _sortItems(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableSliverList(
      delegate: ReorderableSliverChildListDelegate(
          List.generate(widget.items.length, (index) {
        return Dismissible(
          key: Key('${widget.items[index].id}'),
          background: _finishCard,
          secondaryBackground: _archiveCard,
          onDismissed: (direction) {
            final TodoItem tempItem = widget.items[index];
            String action;
            setState(() {
              if (direction == DismissDirection.startToEnd) {
                action = 'finished';
                widget.items[index].finished = true;
              } else {
                action = 'archived';
                widget.items.removeAt(index);
              }
              _sortItems(widget.items);
            });
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${tempItem.itemName} $action!'),
                action: SnackBarAction(
                  label: 'Undo',
                  textColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      if (action == 'finished') {
                        widget.items[index].finished = false;
                      } else {
                        widget.items.insert(index, tempItem);
                      }
                      _sortItems(widget.items);
                    });
                  },
                ),
              ),
            );
          },
          child: Opacity(
            opacity: (widget.items.length * 1.25 - index) /
                (widget.items.length * 1.25),
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
                    value: widget.items[index].finished,
                    onChanged: (value) {
                      setState(() {
                        // FIXME: index has been changed, undo is invalid
                        widget.items[index].finished =
                            !widget.items[index].finished;
                        _sortItems(widget.items);
                      });
                    },
                  ),
                  Text(
                    widget.items[index].itemName,
                    style: TextStyle(
                      decoration: widget.items[index].finished
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
      onReorder: _updateItems,
    );
  }

  void _sortItems(items) =>
      items.sort((a, b) => TodoItem.compareTwoItems(a, b));

  void _updateItems(int oldIndex, int newIndex) {
    setState(() {
      double adjacentPriority;
      if (oldIndex < newIndex) {
        adjacentPriority = newIndex == widget.items.length - 1
            ? 0.0
            : widget.items[newIndex].priority;
        widget.items[oldIndex].priority =
            (widget.items[newIndex].priority + adjacentPriority) / 2;
      } else {
        adjacentPriority =
            newIndex == 0 ? 1.0 : widget.items[newIndex - 1].priority;
        widget.items[oldIndex].priority =
            (widget.items[newIndex].priority + adjacentPriority) / 2;
      }
      TodoItem item = widget.items.removeAt(oldIndex);
      widget.items.insert(newIndex, item);
      _sortItems(widget.items);
    });
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
