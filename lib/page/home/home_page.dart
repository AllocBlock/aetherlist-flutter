import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:aetherlist_flutter/page/home/home_page_mobile.dart';
import 'package:aetherlist_flutter/page/home/home_page_tablet_desktop.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HomePageMobile(),
      tablet: HomePageTabletDesktop(),
      desktop: HomePageTabletDesktop(),
    );
  }
}
