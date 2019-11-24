import 'dart:core';

class TodoItem {
  TodoItem({this.id, this.itemName, this.date, this.priority, this.isDuration, this.finished});

  int id;
  String itemName;
  DateTime date;
  double priority;
  bool isDuration;
  bool finished;
}