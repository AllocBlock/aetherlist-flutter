import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  Item();

  num id;
  num category_id;
  String item_name;
  bool finished;
  num priority;
  bool enable_notification;
  String notify_time;
  bool enable_time_range;
  String due_date;
  String location;
  List tags;
  String description;
  List attachment_list;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);

  bool isDueToday() {
    return due_date == DateFormat("yyyy-MM-dd").format(DateTime.now());
  }

  DateTime parseDate() {
    return DateTime.parse(due_date);
  }

  TimeOfDay parseTime() {
    return TimeOfDay(
        hour: int.parse(notify_time.split(':')[0]),
        minute: int.parse(notify_time.split(':')[1]));
  }
}
