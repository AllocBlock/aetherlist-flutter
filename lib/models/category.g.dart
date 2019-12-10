// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category()
    ..id = int.parse(json['id'])
    ..category_name = json['category_name'] as String;
}

Map<String, dynamic> _$CategoryToJson(Category instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.category_name};
