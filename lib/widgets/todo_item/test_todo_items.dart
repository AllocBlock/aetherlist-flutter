import 'package:aetherlist_flutter/widgets/todo_item/todo_item.dart';

List<TodoItem> items = <TodoItem>[
  TodoItem(
    id: 1,
    itemName: 'item 1',
    priority: 0.9,
    isDuration: false,
    finished: false,
  ),
  TodoItem(
    id: 2,
    itemName: 'item 2',
    priority: 0.5,
    isDuration: false,
    finished: false,
  ),
  TodoItem(
    id: 3,
    itemName: 'item 3',
    priority: 0.8,
    isDuration: true,
    finished: false,
  ),
  TodoItem(
    id: 4,
    itemName: 'item 4',
    priority: 0.4,
    isDuration: false,
    finished: false,
  ),
  TodoItem(
    id: 5,
    itemName: 'item 5',
    priority: 0.6,
    isDuration: false,
    finished: false,
  ),
  TodoItem(
    id: 6,
    itemName: 'item 6',
    priority: 0.3,
    isDuration: true,
    finished: false,
  ),
  TodoItem(
    id: 7,
    itemName: 'item 7',
    priority: 0.1,
    isDuration: false,
    finished: false,
  ),
  TodoItem(
    id: 8,
    itemName: 'item 8',
    priority: 0.2,
    isDuration: false,
    finished: false,
  ),
  TodoItem(
    id: 9,
    itemName: 'item 9',
    priority: 1.0,
    isDuration: false,
    finished: false,
  ),
  TodoItem(
    id: 10,
    itemName: 'item 10',
    priority: 0.7,
    isDuration: true,
    finished: false,
  ),
];

List<TodoItem> todayItems = items.where((item) => item.isDuration == false).toList();
List<TodoItem> laterItems = items.where((item) => item.isDuration == true).toList();