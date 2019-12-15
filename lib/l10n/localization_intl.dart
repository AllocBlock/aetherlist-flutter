import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class CustomLocalizations {
  static Future<CustomLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return CustomLocalizations();
    });
  }

  static CustomLocalizations of(BuildContext context) {
    return Localizations.of<CustomLocalizations>(context, CustomLocalizations);
  }

  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: 'login text',
    );
  }

  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: 'logout text',
    );
  }

  String get logoutTip {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logoutTip',
      desc: 'logout tip text',
    );
  }

  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: 'register text',
    );
  }

  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'cancel text',
    );
  }

  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: 'yes text',
    );
  }

  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: 'no text',
    );
  }

  String get username {
    return Intl.message('Username', name: 'username', desc: 'username text');
  }

  String get usernameRequired {
    return Intl.message('Username required',
        name: 'usernameRequired', desc: 'username required text');
  }

  String get password {
    return Intl.message('Password', name: 'password', desc: 'password text');
  }

  String get passwordRequired {
    return Intl.message('Password required',
        name: 'passwordRequired', desc: 'password required text');
  }

  String get usernameOrPasswordWrong {
    return Intl.message('Username or password wrong',
        name: 'usernameOrPasswordWrong',
        desc: 'username or password wrong text');
  }

  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: 'Category text',
    );
  }

  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: 'Categories text',
    );
  }

  String get futureView {
    return Intl.message(
      'Future',
      name: 'futureView',
      desc: 'futureView text',
    );
  }

  String get statistics {
    return Intl.message(
      'Statistics',
      name: 'statistics',
      desc: 'Statistics text',
    );
  }

  String get archives {
    return Intl.message(
      'Archives',
      name: 'archives',
      desc: 'Archives text',
    );
  }

  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: 'Settings text',
    );
  }

  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: 'Theme text',
    );
  }

  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: 'About text',
    );
  }

  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: 'languages text',
    );
  }

  String get addNewItem {
    return Intl.message(
      'Add new item',
      name: 'addNewItem',
      desc: 'Add new item page title name',
    );
  }

  String get editItem {
    return Intl.message(
      'Edit item',
      name: 'editItem',
      desc: 'Edit item item page title name',
    );
  }

  String get itemTitle {
    return Intl.message(
      'Item title',
      name: 'itemTitle',
      desc: 'item title text',
    );
  }

  String get itemTitleValidation {
    return Intl.message(
      'Item title cannot be empty',
      name: 'itemTitleValidation',
      desc: 'item title validation text',
    );
  }

  String get categoryNameValidation {
    return Intl.message(
      'Category name cannot be empty',
      name: 'categoryNameValidation',
      desc: 'category name validation text',
    );
  }

  String get selectCategoryValidation {
    return Intl.message(
      'Please select a category',
      name: 'selectCategoryValidation',
      desc: 'select category validation text',
    );
  }

  String get newCategoryName {
    return Intl.message(
      'New category name',
      name: 'newCategoryName',
      desc: 'new category name text',
    );
  }

  String get noValidCategory {
    return Intl.message(
      'No valid category',
      name: 'noValidCategory',
      desc: 'no valid category text',
    );
  }

  String get priority {
    return Intl.message(
      'Priority',
      name: 'priority',
      desc: 'priority text',
    );
  }

  String get tags {
    return Intl.message(
      'Tags',
      name: 'tags',
      desc: 'tags text',
    );
  }

  String get timeRangeMode {
    return Intl.message(
      'Time-range mode',
      name: 'timeRangeMode',
      desc: 'time-range mode text',
    );
  }

  String get dueDate {
    return Intl.message(
      'Due date',
      name: 'dueDate',
      desc: 'due date text',
    );
  }

  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: 'notification text',
    );
  }

  String get notifyTime {
    return Intl.message(
      'Notify time',
      name: 'notifyTime',
      desc: 'notify time text',
    );
  }

  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: 'location text',
    );
  }

  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: 'description text',
    );
  }

  String get addItemErrorText {
    return Intl.message(
      'add item failed',
      name: 'addItemErrorText',
      desc: 'add item error text',
    );
  }

  String get removeItemTip {
    return Intl.message(
      'You really want to remove this item?',
      name: 'removeItemTip',
      desc: 'remove item tip text',
    );
  }

  String get removeItemErrorText {
    return Intl.message(
      'remove item failed',
      name: 'removeItemErrorText',
      desc: 'remove item error text',
    );
  }

  String get editItemErrorText {
    return Intl.message(
      'edit item failed',
      name: 'editItemErrorText',
      desc: 'edit item error text',
    );
  }

  String get fetchDataErrorText {
    return Intl.message(
      'fetch data failed',
      name: 'fetchDataErrorText',
      desc: 'fetch data error text',
    );
  }

  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: 'today text',
    );
  }

  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: 'later text',
    );
  }

  String get undo {
    return Intl.message(
      'Undo',
      name: 'undo',
      desc: 'undo text',
    );
  }

  String get manageCategories {
    return Intl.message(
      'Manage categories',
      name: 'manageCategories',
      desc: 'manage categories text',
    );
  }

  String get addCategory {
    return Intl.message(
      'Add category',
      name: 'addCategory',
      desc: 'add category text',
    );
  }

  String get editCategory {
    return Intl.message(
      'edit category',
      name: 'editCategory',
      desc: 'edit category text',
    );
  }

  String get removeCategoryTip {
    return Intl.message(
      'You really want to remove this category?',
      name: 'removeCategoryTip',
      desc: 'remove category tip text',
    );
  }

  String get updateCategoryName {
    return Intl.message(
      'Update category name',
      name: 'updateCategoryName',
      desc: 'update category name text',
    );
  }

  String get addCategoryErrorText {
    return Intl.message(
      'add category failed',
      name: 'addCategoryErrorText',
      desc: 'add category error text',
    );
  }

  String get updateCategoryErrorText {
    return Intl.message(
      'update category failed',
      name: 'updateCategoryErrorText',
      desc: 'update category error text',
    );
  }

  String get removeCategoryErrorText {
    return Intl.message(
      'remove category failed',
      name: 'removeCategoryErrorText',
      desc: 'remove category error text',
    );
  }

  String get addButton {
    return Intl.message(
      'Add',
      name: 'addButton',
      desc: 'add button text',
    );
  }

  String get menuButton {
    return Intl.message(
      'Menu',
      name: 'menuButton',
      desc: 'menu button text',
    );
  }

  String get saveButton {
    return Intl.message(
      'Save',
      name: 'saveButton',
      desc: 'save button text',
    );
  }

  String get deleteButton {
    return Intl.message(
      'Delete',
      name: 'deleteButton',
      desc: 'delete button text',
    );
  }

  String get itemDetails {
    return Intl.message(
      'item details',
      name: 'itemDetails',
      desc: 'item details text',
    );
  }
}

class CustomLocalizationsDelegate
    extends LocalizationsDelegate<CustomLocalizations> {
  const CustomLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<CustomLocalizations> load(Locale locale) {
    return CustomLocalizations.load(locale);
  }

  @override
  bool shouldReload(CustomLocalizationsDelegate old) => false;
}
