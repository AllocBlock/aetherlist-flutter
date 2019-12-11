import 'dart:convert';

import 'package:aetherlist_flutter/common/request.dart';
import 'package:aetherlist_flutter/models/index.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const _themes = <MaterialColor>[
  Colors.cyan,
  Colors.lime,
  Colors.amber,
  Colors.grey,
];

class Global {
  static Box _profileBox;
  static Profile profile = Profile();
  static List<Item> todayItems = [];
  static List<Item> laterItems = [];
  static List<Item> allItems = [];
  static List<Category> categories = [];

  static List<MaterialColor> get themes => _themes;
  static Future init() async {
    _profileBox = await Hive.openBox("myBox");
    var _profile = _profileBox.get("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }
    Request.init();
  }

  static saveProfile() {
    _profileBox.put("profile", profile.toJson());
    print("BoxInfo: ${_profileBox.get("profile")}");
  }
}

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}

class UserModel extends ProfileChangeNotifier {
  User get user => _profile.user;

  bool get isLogin => user != null;

  set user(User user) {
    if (user?.id != _profile.user?.id) {
      _profile.lastLogin = _profile.user?.user_name;
      _profile.user = user;
      notifyListeners();
    }
  }
}

class ThemeModel extends ProfileChangeNotifier {
  ColorSwatch get theme => Global.themes
      .firstWhere((e) => e.value == _profile.theme, orElse: () => Colors.cyan);

  set theme(ColorSwatch color) {
    if (color != theme) {
      _profile.theme = color.value;
      notifyListeners();
    }
  }
}

class LocaleModel extends ProfileChangeNotifier {
  Locale getLocale() {
    if (_profile.locale == null) return null;
    var t = _profile.locale.split("_");
    return Locale(t[0], t[1]);
  }

  String get locale => _profile.locale;

  set locale(String locale) {
    if (locale != _profile.locale) {
      _profile.locale = locale;
      notifyListeners();
    }
  }
}

class ItemsModel extends ChangeNotifier {
  void _toggleFinishItem(List<Item> items, int index) {
    items[index].finished = !items[index].finished;
  }

  void _insertItem(List<Item> items, Item newItem) {
    items.add(newItem);
    _sortItems(items);
  }

  Item _removeItem(List<Item> items, int index) => items.removeAt(index);

  void _updateItemsIndex(List<Item> items, int oldIndex, int newIndex) {
    double adjacentPriority;
    if (oldIndex < newIndex) {
      adjacentPriority =
          newIndex == items.length - 1 ? 0.0 : items[newIndex].priority;
      items[oldIndex].priority =
          (items[newIndex].priority + adjacentPriority) / 2;
    } else {
      adjacentPriority = newIndex == 0 ? 1.0 : items[newIndex - 1].priority;
      items[oldIndex].priority =
          (items[newIndex].priority + adjacentPriority) / 2;
    }
    Item item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    _sortItems(items);
  }

  void _sortItems(List<Item> items) {
    items.sort((a, b) => _compareTwoItems(a, b));
    notifyListeners();
  }

  static int _compareTwoItems(Item a, Item b) {
    if (a.enable_time_range == true && b.enable_time_range != true) {
      return 1;
    } else if (a.enable_time_range == false && b.enable_time_range == true) {
      return -1;
    } else {
      if (a.finished == true && b.finished != true) {
        return 1;
      } else if (a.finished == false && b.finished == true) {
        return -1;
      } else {
        if (a.priority != b.priority) {
          return b.priority.compareTo(a.priority);
        } else {
          return a.item_name.compareTo(b.item_name);
        }
      }
    }
  }
}

class TodayItemsModel extends ItemsModel {
  List<Item> get items => Global.todayItems;
  set items(List<Item> newItems) {
    if (newItems != Global.todayItems) {
      Global.todayItems = newItems;
      notifyListeners();
    }
  }

  Future<bool> fetchItems() async {
    Global.todayItems = await Request.getTodayItems();
    _sortItems(items);
    return true;
  }

  void toggleFinishItem(int index) {
    _toggleFinishItem(items, index);
    _sortItems(items);
  }

  void insertItem(Item newItem) => _insertItem(items, newItem);

  Item removeItem(int index) => _removeItem(items, index);

  void updateItemsIndex(int oldIndex, int newIndex) =>
      _updateItemsIndex(items, oldIndex, newIndex);
}

class LaterItemsModel extends ItemsModel {
  List<Item> get items => Global.laterItems;
  set items(List<Item> newItems) {
    if (newItems != Global.laterItems) {
      Global.laterItems = newItems;
      notifyListeners();
    }
  }

  Future<bool> fetchItems() async {
    Global.laterItems = await Request.getLaterItems();
    _sortItems(items);
    return true;
  }

  void toggleFinishItem(int index) {
    _toggleFinishItem(items, index);
    _sortItems(items);
  }

  void insertItem(Item newItem) => _insertItem(items, newItem);

  void removeItem(int index) => _removeItem(items, index);

  void updateItemsIndex(int oldIndex, int newIndex) =>
      _updateItemsIndex(items, oldIndex, newIndex);
}

class AllItemsModel extends ItemsModel {
  List<Item> get items => Global.allItems;
  List<Category> get categories => Global.categories;

  set allItems(List<Item> newItems) {
    if (newItems != Global.allItems) {
      Global.allItems = newItems;
      notifyListeners();
    }
  }

  Future<bool> addItem(Item item) async {
    if (await Request.addItem(item)) {
      if (item.isDueToday()) {
        Global.todayItems.add(item);
      } else if (item.enable_time_range) {
        Global.laterItems.add(item);
      }
      Global.allItems.add(item);
      return true;
    } else {
      return false;
    }
  }

  void _filterTodayItems() {
    Global.todayItems = Global.allItems.where((e) => e.isDueToday()).toList();
  }

  void _filterLaterItems() {
    Global.laterItems = Global.allItems
        .where((e) => !e.isDueToday() && e.enable_time_range)
        .toList();
  }

  Future<bool> fetchItems() async {
    Global.allItems = await Request.getAllItems();
    _filterTodayItems();
    _filterLaterItems();
    return true;
  }

  Future<bool> fetchCategories() async {
    Global.categories = await Request.getCategories();
    return true;
  }
}
