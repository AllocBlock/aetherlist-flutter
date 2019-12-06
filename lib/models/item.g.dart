// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item()
    ..id = json['id'] as num
    ..category_id = json['category_id'] as num
    ..item_name = json['item_name'] as String
    ..priority = json['priority'] as num
    ..enable_notification = json['enable_notification'] as bool
    ..notify_time = json['notify_time'] as String
    ..due_time = json['due_time'] as String
    ..location = json['location'] as String
    ..tags = json['tags'] as List
    ..description = json['description'] as String
    ..attachment_list = json['attachment_list'] as List;
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'category_id': instance.category_id,
      'item_name': instance.item_name,
      'priority': instance.priority,
      'enable_notification': instance.enable_notification,
      'notify_time': instance.notify_time,
      'due_time': instance.due_time,
      'location': instance.location,
      'tags': instance.tags,
      'description': instance.description,
      'attachment_list': instance.attachment_list
    };
