import 'package:aetherlist_flutter/widgets/todo_item/test_todo_items.dart';
import 'package:aetherlist_flutter/widgets/todo_item/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    super.initState();
    _sortItems(todayItems);
    _sortItems(laterItems);
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController =
        PrimaryScrollController.of(context) ?? ScrollController();
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Center(
            child: Text(
              'Today',
              textScaleFactor: 1.25,
              style: TextStyle(color: Colors.grey[600], height: 2),
            ),
          ),
        ),
        ReorderableSliverList(
          delegate: ReorderableSliverChildListDelegate(
              List.generate(todayItems.length, (index) {
            return Dismissible(
              key: Key('${todayItems[index].id}'),
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
                final TodoItem tempItem = todayItems[index];
                String action;
                setState(() {
                  if (direction == DismissDirection.startToEnd) {
                    action = 'finished';
                    todayItems[index].finished = true;
                  } else {
                    action = 'archived';
                    todayItems.removeAt(index);
                  }
                  _sortItems(todayItems);
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
                            todayItems[index].finished = false;
                          } else {
                            todayItems.insert(index, tempItem);
                          }
                          _sortItems(todayItems);
                        });
                      },
                    ),
                  ),
                );
              },
              child: Opacity(
                opacity: (todayItems.length * 1.25 - index) / (todayItems.length * 1.25),
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
                        value: todayItems[index].finished,
                        onChanged: (value) {
                          setState(() {
                            todayItems[index].finished = !todayItems[index].finished;
                            _sortItems(todayItems);
                          });
                        },
                      ),
                      Text(
                        todayItems[index].itemName,
                        style: TextStyle(
                          decoration: todayItems[index].finished
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
//                      Spacer(),
//                      Text(
//                        '${todayItems[index].priority} ',
//                        textScaleFactor: 0.75,
//                      ),
//                      SizedBox(
//                        width: 12,
//                      )
                    ],
                  ),
                ),
              ),
            );
          })),
          onReorder: _updateTodayItems,
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 15.0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsetsDirectional.only(start: 2.0, end: 2.0),
                height: 1.5,
                color: Colors.grey[200],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: Text(
              'Later',
              textScaleFactor: 1.25,
              style: TextStyle(color: Colors.grey[400], height: 2),
            ),
          ),
        ),
        ReorderableSliverList(
          delegate: ReorderableSliverChildListDelegate(
              List.generate(laterItems.length, (index) {
                return Dismissible(
                  key: Key('${laterItems[index].id}'),
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
                    final TodoItem tempItem = laterItems[index];
                    String action;
                    setState(() {
                      if (direction == DismissDirection.startToEnd) {
                        action = 'finished';
                        laterItems[index].finished = true;
                      } else {
                        action = 'archived';
                        laterItems.removeAt(index);
                      }
                      _sortItems(laterItems);
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
                                laterItems[index].finished = false;
                              } else {
                                laterItems.insert(index, tempItem);
                              }
                              _sortItems(laterItems);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: Opacity(
                    opacity: (laterItems.length * 1.25 - index) / (laterItems.length * 2.5),
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
                            value: laterItems[index].finished,
                            onChanged: (value) {
                              setState(() {
                                laterItems[index].finished = !laterItems[index].finished;
                                _sortItems(laterItems);
                              });
                            },
                          ),
                          Text(
                            laterItems[index].itemName,
                            style: TextStyle(
                              decoration: laterItems[index].finished
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
//                      Spacer(),
//                      Text(
//                        '${todayItems[index].priority} ',
//                        textScaleFactor: 0.75,
//                      ),
//                      SizedBox(
//                        width: 12,
//                      )
                        ],
                      ),
                    ),
                  ),
                );
              })),
          onReorder: _updateLaterItems,
        ),
      ],
    );
  }

  void _sortItems(items) => items.sort((a, b) => TodoItem.compareTwoItems(a, b));

  void _updateItems(List<TodoItem>items, int oldIndex, int newIndex) {
    setState(() {
      double adjacentPriority;
      if (oldIndex < newIndex) {
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
      _sortItems(items);
    });
  }

  void _updateTodayItems(int oldIndex, int newIndex) {
    _updateItems(todayItems, oldIndex, newIndex);
  }

  void _updateLaterItems(int oldIndex, int newIndex) {
    _updateItems(laterItems, oldIndex, newIndex);
  }
}
