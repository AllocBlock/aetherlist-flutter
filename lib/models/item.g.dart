// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
//  return Item()
//    ..id = json['id'] as num
//    ..category_id = json['category_id'] as num
//    ..item_name = json['item_name'] as String
//    ..finished = json['finished'] as bool
//    ..priority = json['priority'] as num
//    ..enable_notification = json['enable_notification'] as bool
//    ..notify_time = json['notify_time'] as String
//    ..enable_time_range = json['enable_time_range'] as bool
//    ..due_date = json['due_date'] as String
//    ..location = json['location'] as String
//    ..tags = json['tags'] as List
//    ..description = json['description'] as String
//    ..attachment_list = json['attachment_list'] as List;
  return Item()
    ..id = int.parse(json['id'])
    ..category_id = int.parse(json['category_id'])
    ..item_name = json['item_name'] as String
    ..finished = json['finished'] == "1"
    ..priority = double.parse(json['priority'])
    ..enable_notification = json['enable_notification'] == "1"
    ..notify_time = json['notify_time'] as String
    ..enable_time_range = json['enable_time_range'] == "1"
    ..due_date = json['due_date'] as String
    ..location = json['location'] as String
    ..tags = json['tags'] as List
    ..description = json['description'] as String
    ..attachment_list = json['attachment_list'] as List;
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'category_id': instance.category_id,
      'item_name': instance.item_name,
      'finished': instance.finished,
      'priority': instance.priority,
      'enable_notification': instance.enable_notification,
      'notify_time': instance.notify_time,
      'enable_time_range': instance.enable_time_range,
      'due_date': instance.due_date,
      'location': instance.location,
      'tags': instance.tags,
      'description': instance.description,
      'attachment_list': instance.attachment_list
    };
