import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:logger/logger.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rocktodo/bean/todo/set/todo_item.dart';
import 'package:rocktodo/common/common_config.dart';
import 'package:rocktodo/common/theme.dart';
import 'package:rocktodo/net/rock_net.dart';

class ToDoItemListWidget extends StatefulWidget {
  final int todoSetId;

  ToDoItemListWidget({@required this.todoSetId});

  @override
  State<StatefulWidget> createState() {
    return new _ToDoItemListState(todoSetId: todoSetId);
  }
}

class _ToDoItemListState extends State<ToDoItemListWidget> {
  final int todoSetId;

  ToDoList _toDoList = ToDoList();

  _ToDoItemListState({@required this.todoSetId});

  List<ToDoItem> get _toDoItemList {
    if (_toDoList.todoList == null) {
      return List();
    } else {
      return _toDoList.todoList;
    }
  }

  @override
  void initState() {
    super.initState();
    if (!CommonConfig.inProduction) {
      Logger logger = Logger();
      logger.d('todoSetid透传:' + todoSetId.toString());
    }
    _initDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RockToDo'),
      ),
      body: Container(
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
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Container(
                    width: 60.0,
                    height: 60.0,
                    child: Center(
                      child: Text(
                        _toDoItemList[index].comment,
                      ),
                    ),
                    color: appItemColors[index % 7],
                  );
                }, childCount: _toDoItemList.length),
              ),
            ]),
      ),
    );
  }

  void _initDatas() {
    RockNet rockNet = RockNet();
    rockNet.post(
      path: "rest_api/query_todo_item_list",
      params: {"todo_set_id": todoSetId},
    ).then((value) {
      ToDoList toDoList = ToDoList.fromJson(value);
      setState(() {
        _toDoList = toDoList;
      });
    }).catchError((e) {
      showToast("数据获取出错");
      _toDoList = ToDoList();
    });
  }
}
