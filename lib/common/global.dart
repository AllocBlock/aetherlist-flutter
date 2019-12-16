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
  static List<Item> historyItems = [];
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
  void _toggleFinishItem(List<Item> items, int index) async {
    items[index].finished = !items[index].finished;
    Global.allItems.firstWhere((e) => e.id == items[index].id).finished =
        items[index].finished;
    if (!await Request.editItem(items[index])) {
      items[index].finished = !items[index].finished;
      Global.allItems.firstWhere((e) => e.id == items[index].id).finished =
          items[index].finished;
    }
  }

  void _insertItem(List<Item> items, Item newItem) {
    items.add(newItem);
    _sortItems(items);
  }

  Item _removeItem(List<Item> items, int index) {
    Global.allItems.removeWhere((e) => e.id == items[index].id);
    Request.removeItem(items[index]).then((succeed) {
      if (succeed) {
        notifyListeners();
        return items.removeAt(index);
      } else {
        Global.allItems.add(items[index]);
        return Item();
      }
    });
    return Item();
  }

  void _updateItemsIndex(List<Item> items, int oldIndex, int newIndex) async {
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
    Global.allItems.firstWhere((e) => e.id == items[newIndex].id).priority =
        items[newIndex].priority;
    await Request.editItem(items[newIndex]);
    notifyListeners();
  }

  void _sortItems(List<Item> items) {
    items.sort((a, b) => _compareTwoItems(a, b));
    notifyListeners();
  }

  static int _compareTwoItems(Item a, Item b) {
    if (a.finished == true && b.finished != true) {
      return 1;
    } else if (a.finished == false && b.finished == true) {
      return -1;
    } else {
      if (a.enable_time_range == true && b.enable_time_range != true) {
        return 1;
      } else if (a.enable_time_range == false && b.enable_time_range == true) {
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
  List<Item> get historyItems => Global.historyItems;
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

  Future<bool> editItem(Item item) async {
    if (await Request.editItem(item)) {
      Global.todayItems.removeWhere((e) => e.id == item.id);
      Global.laterItems.removeWhere((e) => e.id == item.id);
      Global.allItems.removeWhere((e) => e.id == item.id);
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

  Future<bool> removeItem(Item item) async {
    Global.allItems.removeWhere((e) => e.id == item.id);
    if (await Request.removeItem(item)) {
      if (item.isDueToday()) {
        Global.todayItems.removeWhere((e) => e.id == item.id);
      } else if (item.enable_time_range) {
        Global.laterItems.removeWhere((e) => e.id == item.id);
      }
      notifyListeners();
      return true;
    } else {
      Global.allItems.add(item);
      return false;
    }
  }

  void _filterTodayItems() {
    Global.todayItems = Global.allItems.where((e) => e.isDueToday()).toList();
    _sortItems(Global.todayItems);
  }

  void _filterLaterItems() {
    Global.laterItems = Global.allItems
        .where((e) => !e.isDueToday() && e.enable_time_range)
        .toList();
    _sortItems(Global.laterItems);
  }

  void _filterHistoryItems() {
    final DateTime nowDate = DateTime.now();
    Global.historyItems = Global.allItems
        .where((e) => e
            .parseDate()
            .isBefore(DateTime(nowDate.year, nowDate.month, nowDate.day)))
        .toList();
    print(Global.historyItems.toString());
  }

  Future<bool> fetchItems() async {
    Global.allItems = await Request.getAllItems();
    _filterTodayItems();
    _filterLaterItems();
    _filterHistoryItems();

    Global.historyItems.sort((Item a, Item b) {
      return b.due_date.compareTo(a.due_date);
    });
    notifyListeners();
    return true;
  }

  // TODO: use CategoriesModel to control categories
  Future<bool> fetchCategories() async {
    Global.categories = await Request.getCategories();
    return true;
  }

  // TODO: use CategoriesModel to control categories
  Future<bool> addCategory(String categoryName) async {
    Category category = Category();
    category.category_name = categoryName;
    category.id = await Request.addCategory(categoryName);
    if (category.id != null && category.id != -1) {
      Global.categories.add(category);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  // TODO: use CategoriesModel to control categories
  Future<bool> updateCategory(Category category, String newName) async {
    category.category_name = newName;
    if (await Request.updateCategory(category)) {
      for (var e in Global.categories) {
        if (e.id == category.id) {
          e.category_name = newName;
        }
        notifyListeners();
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  // TODO: use CategoriesModel to control categories
  Future<bool> removeCategory(Category category) async {
    if (await Request.removeCategory(category.id)) {
      Global.categories.removeWhere((e) => e.id == category.id);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
