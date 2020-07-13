import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs = ["ToDo", "Blog", "To Be Continued..."];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RockToDo'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.dashboard,
                color: Colors.white,
              ),
              onPressed: () {
                // 打开抽屉菜单
                showToast("抽屉菜单功能待开发");
              },
            );
          },
        ),
        bottom: TabBar(
            controller: _tabController,
            tabs: tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              e,
              textScaleFactor: 3,
            ),
          );
        }).toList(),
      ),
    );
  }
}
