import 'package:aetherlist_flutter/widgets/todo_item/test_todo_items.dart';
import 'package:aetherlist_flutter/widgets/todo_item/todo_item.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    super.initState();
    items.sort((a, b) => b.priority.compareTo(a.priority));
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        header: Text(
          'Today',
          textScaleFactor: 1.25,
          style: TextStyle(color: Colors.grey[600], height: 2),
        ),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            _updateItems(oldIndex, newIndex);
          });
        },
        children: List.generate(items.length, (index) {
          return Dismissible(
            key: Key('${items[index].id}'),
            background: Card(
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
            ),
            secondaryBackground: Card(
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
            ),
            onDismissed: (direction) {
              final TodoItem tempItem = items[index];
              String action;
              setState(() {
                if (direction == DismissDirection.startToEnd) {
                  action = 'finished';
                  items[index].finished = true;
                } else {
                  action = 'archived';
                  items.removeAt(index);
                }
                _sortItems();
              });

              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("${tempItem.itemName} $action!"),
                  action: SnackBarAction(
                    label: 'Undo',
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        if (direction == DismissDirection.startToEnd) {
                          items[index].finished = false;
                        } else {
                          items.insert(index, tempItem);
                        }
                        _sortItems();
                      });
                    },
                  ),
                ),
              );
            },
            child: Opacity(
              opacity: (items.length * 1.25 - index) / (items.length * 1.25),
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
                      value: items[index].finished,
                      onChanged: (value) {
                        setState(() {
                          items[index].finished = !items[index].finished;
                          _sortItems();
                        });
                      },
                    ),
                    Text(
                      items[index].itemName,
                      style: TextStyle(
                        decoration: items[index].finished
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${items[index].priority} ',
                      textScaleFactor: 0.75,
                    ),
                    SizedBox(
                      width: 12,
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }

  void _sortItems() => items.sort((a, b) => TodoItem.compareTwoItems(a, b));

  void _updateItems(int oldIndex, int newIndex) {
    setState(() {
      double adjacentPriority;
      if (oldIndex < newIndex) {
        --newIndex;
        adjacentPriority =
            newIndex == items.length - 1 ? 0.0 : items[newIndex].priority;
        items[oldIndex].priority =
            (items[newIndex].priority + adjacentPriority) / 2;
      } else {
        adjacentPriority = newIndex == 0 ? 1.0 : items[newIndex - 1].priority;
        items[oldIndex].priority =
            (items[newIndex].priority + adjacentPriority) / 2;
      }
      TodoItem item = items.removeAt(oldIndex);
      items.insert(newIndex, item);
      _sortItems();
    });
  }
}
