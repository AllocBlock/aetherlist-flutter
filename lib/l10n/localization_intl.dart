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

  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: 'Categories text in navigation drawer',
    );
  }

  String get statistics {
    return Intl.message(
      'Statistics',
      name: 'statistics',
      desc: 'Statistics text in navigation drawer',
    );
  }

  String get archives {
    return Intl.message(
      'Archives',
      name: 'archives',
      desc: 'Archives text in navigation drawer',
    );
  }

  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: 'Settings text in navigation drawer',
    );
  }

  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: 'About text in navigation drawer',
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
