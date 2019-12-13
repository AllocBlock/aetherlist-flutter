import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/l10n/localization_intl.dart';
import 'package:aetherlist_flutter/page/about/about.dart';
import 'package:aetherlist_flutter/page/add/add_page.dart';
import 'package:aetherlist_flutter/page/home/home_page.dart';
import 'package:aetherlist_flutter/page/profile/login.dart';
import 'package:aetherlist_flutter/page/profile/register.dart';
import 'package:aetherlist_flutter/page/settings/language_page.dart';
import 'package:aetherlist_flutter/page/settings/settings.dart';
import 'package:aetherlist_flutter/page/settings/theme_page.dart';
import 'package:aetherlist_flutter/page/statistics/statistics.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => Global.init().then((e) => runApp(App()));

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
        ChangeNotifierProvider.value(value: AllItemsModel()),
        ChangeNotifierProvider.value(value: TodayItemsModel()),
        ChangeNotifierProvider.value(value: LaterItemsModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(builder:
          (BuildContext context, themeModel, localeModel, Widget child) {
        return BotToastInit(
          child: MaterialApp(
            navigatorObservers: [BotToastNavigatorObserver()],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: themeModel.theme,
              cardColor: themeModel.theme[200],
            ),
            home: HomePage(),
            locale: localeModel.getLocale(),
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('zh', 'CN'),
            ],
            localizationsDelegates: [
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              CustomLocalizationsDelegate()
            ],
            localeResolutionCallback:
                (Locale _locale, Iterable<Locale> supportedLocales) {
              if (localeModel.getLocale() != null) {
                return localeModel.getLocale();
              } else {
                Locale locale;
                if (supportedLocales.contains(_locale)) {
                  locale = _locale;
                } else {
                  locale = Locale('en', 'US');
                }
                return locale;
              }
            },
            routes: <String, WidgetBuilder>{
              '/login': (context) => LoginPage(),
              '/register': (context) => RegisterPage(),
              '/statistics': (context) => StatisticsPage(),
              '/settings': (context) => SettingPage(),
              '/about': (context) => AboutPage(),
              '/add': (context) => AddPage(),
              '/settings/theme': (context) => ThemePage(),
              '/settings/language': (context) => LanguagePage(),
            },
          ),
        );
      }),
    );
  }
}
