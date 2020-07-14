import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:rocktodo/bean/todo/set/todo_set.dart';
import 'package:rocktodo/net/rock_net.dart';

class ToDoSetListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    print("new me");
    return new _ToDoSetListState();
  }
}

class _ToDoSetListState extends State<ToDoSetListWidget>
    with AutomaticKeepAliveClientMixin {
  List<ToDoSet> _toDoSetList = List();
  List<Color> _colorList = [
    Colors.red[300],
    Colors.orange[300],
    Colors.yellow[300],
    Colors.green[300],
    Colors.cyan[300],
    Colors.blue[300],
    Colors.purple[300],
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initDatas();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.all(2.0),
      child: EasyRefresh.custom(
          enableControlFinishRefresh: false,
          onRefresh: _refresh,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  width: 60.0,
                  height: 60.0,
                  child: Center(
                    child: Text(
                      _toDoSetList[index].name,
                    ),
                  ),
                  color: _colorList[index % 7],
                );
              }, childCount: _toDoSetList.length),
            ),
          ]),
    );
  }

  /*ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _toDoSetList[index].name,
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                height: .0,
              ),
              itemCount: _toDoSetList.length)*/

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void _initDatas() {
    RockNet rockNet = RockNet();
    rockNet.post(path: "rest_api/query_todo_set").then((value) {
      List<ToDoSet> todoSetList = List();
      if (value is Iterable && value.isNotEmpty) {
        for (var item in value) {
          todoSetList.add(ToDoSet.fromJson(item));
        }
      }
      setState(() {
        _toDoSetList = todoSetList;
      });
    }).catchError((e) {
      _toDoSetList = List();
    });
  }

  Future<void> _refresh() async {
    _toDoSetList.clear();
    await _initDatas();
    return;
  }
}
