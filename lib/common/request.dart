import 'dart:convert';

import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/models/index.dart';
import 'package:aetherlist_flutter/models/user.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Request {
  Request([this.context]);

  static const String _requestUrl =
      "https://www.foodiesnotalone.cn/aetherlist/server.php";
  BuildContext context;

  // TODO: add initialization
  static void init() {}

  static Future<User> login(String userName, String passwd) async {
    String device_number = "null";
    var requestData;
    try {
      Response response = await Dio().get(_requestUrl, queryParameters: {
        "opcode": "login",
        "user_name": userName,
        "passwd": passwd,
        "device_number": device_number
      });
      //print(response.toString());
      requestData = json.decode(response.toString());
    } catch (e) {
      print(e);
    }
    if (requestData['result'] == 'fail') {
      return null;
    } else {
      Global.profile.session = requestData['session'];
      Map<String, dynamic> json = {
        'id': 0,
        'user_name': userName,
        'passwd': passwd
      };
      return User.fromJson(json);
    }
  }

  static Future<bool> register(String userName, String passwd) async {
    String device_number = "null";
    String encoded_passwd = passwd;
    try {
      Response response = await Dio().get(_requestUrl, queryParameters: {
        "opcode": "register",
        "user_name": userName,
        "passwd": encoded_passwd,
        "device_number": device_number
      });

      //print(response.toString());
      var requestData = json.decode(response.toString());
      return requestData['result'] == 'success';
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<List<Category>> getCategories() async {
    String session = Global.profile.session;
    var requestData;
    try {
      Response response = await Dio().get(_requestUrl,
          queryParameters: {"opcode": "getCategory", "session": session});
//          print(response.toString());
      requestData = jsonDecode(response.toString());
    } catch (e) {
      BotToast.showText(text: e.toString());
      print(e);
    }
    if (requestData['result'] == "fail")
      return null;
    else
      return List<Category>.from(
          await requestData['data'].map((e) => Category.fromJson(e)));
  }

  static Future<List<Item>> getAllItems() async {
    String session = Global.profile.session;
    var requestData;
    try {
      Response response = await Dio().get(_requestUrl,
          queryParameters: {"opcode": "getAllItems", "session": session});
//      print(response.toString());
      requestData = jsonDecode(response.toString());
    } catch (e) {
      print(e);
    }
    if (requestData['result'] == "fail") {
      return null;
    } else {
      return List<Item>.from(
          await requestData['data'].map((e) => Item.fromJson(e)));
    }
  }

  static Future<List<Item>> getTodayItems() async {
    String session = Global.profile.session;
    var requestData;
    try {
      Response response = await Dio().get(_requestUrl,
          queryParameters: {"opcode": "getTodayItems", "session": session});
      //print(response.toString());
      requestData = jsonDecode(response.toString());
    } catch (e) {
      print(e);
    }
    if (requestData['result'] == "fail") {
      return null;
    } else {
      return List<Item>.from(
          await requestData['data'].map((e) => Item.fromJson(e)));
    }
  }

  static Future<List<Item>> getLaterItems() async {
    String session = Global.profile.session;
    var requestData;
    try {
      Response response = await Dio().get(_requestUrl,
          queryParameters: {"opcode": "getLaterItems", "session": session});
      //print(response.toString());
      requestData = jsonDecode(response.toString());
    } catch (e) {
      print(e);
    }
    if (requestData['result'] == "fail")
      return null;
    else
      return List<Item>.from(
          await requestData['data'].map((e) => Item.fromJson(e)));
  }

  static Future<bool> addItem(Item item) async {
    Dio dio = Dio();
    String session = Global.profile.session;
    var requestData;
    try {
      Response response = await dio.get(_requestUrl, queryParameters: {
        "opcode": "editItem",
        "session": session,
        "data": jsonEncode(item),
      });
      requestData = jsonDecode(response.toString());
    } catch (e) {
      print(e);
    }
    print('@requestData: $requestData');
    return requestData['result'] != 'fail';
  }

  static Future<bool> editItem(Item item) async => addItem(item);

  static Future<bool> removeItem(Item item) async {
    Dio dio = Dio();
    String session = Global.profile.session;
    var requestData;
    try {
      Response response = await dio.get(_requestUrl, queryParameters: {
        "opcode": "deleteItem",
        "session": session,
        "item_id": item.id,
      });
      requestData = jsonDecode(response.toString());
    } catch (e) {
      print(e);
    }
    print('@requestData: $requestData');
    return requestData['result'] != 'fail';
  }

  static Future<int> addCategory(String categoryName) async {
    Dio dio = Dio();
    String session = Global.profile.session;
    var requestData;
    try {
      Response response = await dio.get(_requestUrl, queryParameters: {
        "opcode": "addCategory",
        "session": session,
        "category_name": categoryName,
      });
      requestData = jsonDecode(response.toString());
    } catch (e) {
      print(e);
    }
    print('@requestData: $requestData');
    if (requestData['result'] == 'fail') {
      return -1;
    } else {
      return int.parse(requestData['category_id']);
    }
  }

  static Future<bool> updateCategory(Category category) async {
    Dio dio = Dio();
    String session = Global.profile.session;
    var requestData;
    try {
      Response response = await dio.get(_requestUrl, queryParameters: {
        "opcode": "updateCategory",
        "session": session,
        "category_id": category.id,
        "new_name": category.category_name,
      });
      requestData = jsonDecode(response.toString());
    } catch (e) {
      print(e);
    }
    print('@requestData: $requestData');
    return requestData['result'] != 'fail';
  }

  static Future<bool> removeCategory(int categoryId) async {
    Dio dio = Dio();
    String session = Global.profile.session;
    var requestData;
    try {
      Response response = await dio.get(_requestUrl, queryParameters: {
        "opcode": "deleteCategory",
        "session": session,
        "category_id": categoryId,
      });
      requestData = jsonDecode(response.toString());
    } catch (e) {
      print(e);
    }
    print('@requestData: $requestData');
    return requestData['result'] != 'fail';
  }
}
