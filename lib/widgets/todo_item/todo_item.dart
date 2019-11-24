import 'dart:core';

class TodoItem {
  TodoItem(
      {this.id,
      this.itemName,
      this.date,
      this.priority,
      this.isDuration,
      this.finished});

  int id;
  String itemName;
  DateTime date;
  double priority;
  bool isDuration;
  bool finished;

  static int compareTwoItems(TodoItem a, TodoItem b) {
    if (a.isDuration == true && b.isDuration != true) {
      return 1;
    } else if (a.isDuration == false && b.isDuration == true) {
      return -1;
    } else {
      if (a.finished == true && b.finished != true) {
        return 1;
      } else if (a.finished == false && b.finished == true) {
        return -1;
      } else {
        return b.priority.compareTo(a.priority);
      }
    }
  }
}
