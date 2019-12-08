import 'package:aetherlist_flutter/models/index.dart';
import 'package:aetherlist_flutter/models/user.dart';
import 'package:flutter/cupertino.dart';

class Request {
  Request([this.context]);

  BuildContext context;

  // TODO: add initialization
  static void init() {}

  Future<User> login(String userName, String passwd) async {
    // TODO: add web request to get login data
    var requestData;
    return User.fromJson(requestData.data);
  }

  Future<bool> register(String userName, String passwd) async {
    // TODO: add web request to register
    return true;
  }

  Future<List<Item>> getAllItems() async {
    // TODO: add web request to get all items
    var requestData;
    return requestData.data.map((e) => Item.fromJson(e)).toList();
  }
}
