import 'dart:core';

class TodoItem {
  TodoItem(
      {this.id,
      this.itemName,
      this.dueDate,
      this.priority,
      this.isDuration,
      this.finished,
      this.location,
      this.enableNotification,
      this.notifyTime,
      this.tagList,
      this.description,
      this.attachmentList});

  int id;
  String itemName;
  DateTime dueDate;
  double priority;
  bool isDuration;
  bool finished;
  String location;
  bool enableNotification;
  DateTime notifyTime;
  List<String> tagList;
  String description;
  List<String> attachmentList;


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
