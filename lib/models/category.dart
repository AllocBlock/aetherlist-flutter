import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
    Category();

    num id;
    String name;
    num account_id;
    
    factory Category.fromJson(Map<String,dynamic> json) => _$CategoryFromJson(json);
    Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
