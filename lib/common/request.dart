import 'dart:convert';

import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/models/index.dart';
import 'package:aetherlist_flutter/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Request {
  Request([this.context]);

  BuildContext context;

  // TODO: add initialization
  static void init() {}

  static Future<User> login(String userName, String passwd) async {
    String device_number = "null";
    var requestData;

    try {
      Response response = await Dio().get(
          "https://www.foodiesnotalone.cn/aetherlist/server.php",
          queryParameters: {
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
    if (requestData['result'] == 'failed') {
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
      Response response = await Dio().get(
          "https://www.foodiesnotalone.cn/aetherlist/server.php",
          queryParameters: {
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

  static Future<List<Item>> getAllItems() async {
    String session = Global.profile.session;
    var requestData;

    try {
      Response response = await Dio().get(
          "https://www.foodiesnotalone.cn/aetherlist/server.php",
          queryParameters: {"opcode": "getAllItems", "session": session});
      //print(response.toString());
      requestData = jsonDecode(response.toString());
    } catch (e) {
      print(e);
    }

    if (requestData['result'] == "fail")
      return null;
    else
      return requestData['data'].map((e) => Item.fromJson(e)).toList();
  }

  static Future<List<Item>> getTodayItems() async {
    String session = Global.profile.session;
    var requestData;
    try {
      Response response = await Dio().get(
          "https://www.foodiesnotalone.cn/aetherlist/server.php",
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
      Response response = await Dio().get(
          "https://www.foodiesnotalone.cn/aetherlist/server.php",
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
}
