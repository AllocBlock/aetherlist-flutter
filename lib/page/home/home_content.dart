import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/common/request.dart';
import 'package:aetherlist_flutter/l10n/localization_intl.dart';
import 'package:aetherlist_flutter/models/index.dart';
import 'package:aetherlist_flutter/widgets/items_sliver_list/items_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      return Center(
        child: RaisedButton(
          child: Text(CustomLocalizations.of(context).login),
          onPressed: () => Navigator.of(context).pushNamed("/login"),
        ),
      );
    } else {
      ScrollController _scrollController =
          PrimaryScrollController.of(context) ?? ScrollController();
      return CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          // TODO: add progress bar for today items
          SliverToBoxAdapter(
            child: Center(
              child: Text(
                'Today',
                textScaleFactor: 1.25,
                style: TextStyle(color: Colors.grey[600], height: 2),
              ),
            ),
          ),
          ItemsSliverList(
            isTodayItem: true,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 15.0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: 2.0, end: 2.0),
                  height: 1.5,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Text(
                'Later',
                textScaleFactor: 1.25,
                style: TextStyle(color: Colors.grey[400], height: 2),
              ),
            ),
          ),
          // FIXME: drag items from laterItems to todayItems will crash the widget
          ItemsSliverList(
            isTodayItem: false,
          ),
        ],
      );
    }
  }
}
