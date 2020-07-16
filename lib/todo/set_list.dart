import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:rocktodo/bean/todo/set/todo_set.dart';
import 'package:rocktodo/common/theme.dart';
import 'package:rocktodo/net/rock_net.dart';
import 'package:rocktodo/todo/todo_item_list.dart';

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
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2), () {
              if (mounted) {
                _initDatas();
              }
            });
          },
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> ToDoItemListWidget(todoSetId: _toDoSetList[index].id,)
                      ));
                    },
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      child: Center(
                        child: Text(
                          _toDoSetList[index].name,
                        ),
                      ),
                      color: appItemColors[index % 7],
                    ),
                  );
                },
                childCount: _toDoSetList.length,
              ),
            ),
          ]),
    );
  }

  @override
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
}
