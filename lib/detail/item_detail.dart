import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rocktodo/bean/todo/set/todo_item.dart';
import 'package:rocktodo/net/rock_net.dart';

class ToDoItemDetailWidget extends StatefulWidget {
  final String todoItemId;

  ToDoItemDetailWidget({@required this.todoItemId});

  @override
  State<StatefulWidget> createState() {
    return new _ToDoItemDetailState(todoItemId: todoItemId);
  }
}

class _ToDoItemDetailState extends State<ToDoItemDetailWidget> {
  final String todoItemId;

  ToDoItem _todoItem;

  _ToDoItemDetailState({@required this.todoItemId});

  @override
  void initState() {
    super.initState();
    _initDatas();
  }

  void _initDatas() {
    RockNet rockNet = RockNet();
    rockNet.post(
      path: "rest_api/query_todo_item_list",
      params: {"todo_item_id": todoItemId},
    ).then((value) {
      ToDoItem todoItem = ToDoItem.fromJson(value);
      setState(() {
        _todoItem = todoItem;
      });
    }).catchError((e) {
      showToast("数据获取出错");
      _todoItem = ToDoItem();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(_todoItem.toString()),
    );
  }
}
