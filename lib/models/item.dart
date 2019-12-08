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
    String due_time;
    String location;
    List tags;
    String description;
    List attachment_list;
    
    factory Item.fromJson(Map<String,dynamic> json) => _$ItemFromJson(json);
    Map<String, dynamic> toJson() => _$ItemToJson(this);
}
