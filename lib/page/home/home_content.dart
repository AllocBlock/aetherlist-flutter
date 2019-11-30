import 'package:aetherlist_flutter/widgets/items_sliver_list/items_sliver_list.dart';
import 'package:aetherlist_flutter/widgets/todo_item/test_todo_items.dart';
import 'package:flutter/material.dart';

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
          items: todayItems,
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
          items: laterItems,
        ),
      ],
    );
  }
}
