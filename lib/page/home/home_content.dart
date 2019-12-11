import 'package:aetherlist_flutter/common/global.dart';
import 'package:aetherlist_flutter/l10n/localization_intl.dart';
import 'package:aetherlist_flutter/widgets/items_sliver_list/items_sliver_list.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  AsyncMemoizer<bool> todayMemoizer;
  AsyncMemoizer<bool> laterMemoizer;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    bool connectionResult =
        await Provider.of<AllItemsModel>(context).fetchItems();
    if (connectionResult) {
      _refreshController.refreshCompleted();
    } else {
      _refreshController.refreshFailed();
    }
  }

  @override
  void initState() {
    todayMemoizer = AsyncMemoizer();
    laterMemoizer = AsyncMemoizer();
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
      return SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: MaterialClassicHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: CustomScrollView(
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
            Consumer<TodayItemsModel>(
                builder: (BuildContext context, itemModel, Widget child) {
              return FutureBuilder<bool>(
                future: todayMemoizer.runOnce(itemModel.fetchItems),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("yes!");
                    if (snapshot.data == true)
                      return ItemsSliverList(itemModel: itemModel);
                    else
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text("Fetch data failed"),
                        ),
                      );
                  } else if (snapshot.hasError) {
                    print("error");
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text("${snapshot.error}"),
                      ),
                    );
                  } else {
                    print("processing");

                    return SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              );
            }),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20.0,
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
            Consumer<LaterItemsModel>(
                builder: (BuildContext context, itemModel, Widget child) {
              return FutureBuilder<bool>(
                future: laterMemoizer.runOnce(itemModel.fetchItems),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ItemsSliverList(itemModel: itemModel);
                  } else if (snapshot.hasError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text("${snapshot.error}"),
                      ),
                    );
                  } else {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              );
            }),
          ],
        ),
      );
    }
  }
}
