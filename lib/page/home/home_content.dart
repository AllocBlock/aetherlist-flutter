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
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ReorderableListView(
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                _updateItems(oldIndex, newIndex);
              });
            },
            children: List.generate(items.length, (index) {
              return Opacity(
                key: Key('${items[index].id}'),
                opacity: (items.length * 1.25 - index) / (items.length * 1.25),
                child: Card(
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
                          });
                        },
                      ),
                      Text(
                        items[index].itemName,
                      ),
                      Spacer(),
                      Text(
                        '${items[index].priority} ', textScaleFactor: 0.75,
                      ),
                      SizedBox(width: 12,)
                    ],
                  ),
                ),
              );
            })
        ),
      ),
    );
  }

  void _updateItems(int oldIndex, int newIndex) {
    setState(() {
      double adjacentPriority;
      if (oldIndex < newIndex) {
        --newIndex;
        adjacentPriority = newIndex == items.length - 1 ? 0.0 : items[newIndex].priority;
        items[oldIndex].priority = (items[newIndex].priority + adjacentPriority) / 2;
      } else {
        adjacentPriority = newIndex == 0 ? 1.0 : items[newIndex - 1].priority;
        items[oldIndex].priority = (items[newIndex].priority + adjacentPriority) / 2;
      }
      TodoItem item = items.removeAt(oldIndex);
      items.insert(newIndex, item);
      items.sort((a, b) => b.priority.compareTo(a.priority));
    });
  }
}
