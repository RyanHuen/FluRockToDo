import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rocktodo/bean/todo/set/todo_item.dart';
import 'package:rocktodo/common/theme.dart';
import 'package:rocktodo/detail/item_detail.dart';
import 'package:rocktodo/net/rock_net.dart';
import 'package:rocktodo/util/time_util.dart';

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
  bool editing = false;

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
    _initDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _toDoList.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            Expanded(
              child: EasyRefresh(
                enableControlFinishRefresh: false,
                onRefresh: () async {
                  await Future.delayed(Duration(milliseconds: 500), () {
                    if (mounted) {
                      _initDatas();
                    }
                  });
                },
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      floating: true,
                      flexibleSpace: SingleChildScrollView(
                        child: Container(
                            child: Padding(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, right: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.widgets,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    _toDoList.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      editing ? Icons.done : Icons.edit,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        editing = !editing;
                                      });
                                    },
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  "创建时间： " +
                                      TimeUtil.timeFormat(
                                          _toDoList.createTimestamp),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "是否启用：",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Switch(
                                        value: _toDoList.enable,
                                        activeColor: Colors.green[500],
                                        onChanged: (value) {
                                          if (editing) {
                                            setState(() {
                                              _toDoList.enable = value;
                                            });
                                          }
                                        })
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                      ),
                      expandedHeight: 130,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 15,
                              bottom:
                                  index == _toDoItemList.length - 1 ? 15 : 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ToDoItemDetailWidget(
                                    todoItemId: _toDoItemList[index].todoItemId,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: appItemColors[index % 7],
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(3, 1),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      color: appItemColors[index % 7],
                                    ),
                                  ]),
                              height: 100.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 10),
                                        child: ToggleButtons(
                                          isSelected: ToDoItemModel.parseState(
                                            _toDoItemList[index],
                                          ),
                                          constraints: BoxConstraints(
                                            maxWidth: 100,
                                          ),
                                          children: <Widget>[
                                            Icon(
                                              Icons.access_alarm,
                                            ),
                                            Icon(
                                              Icons.schedule,
                                            ),
                                            Icon(
                                              Icons.done,
                                            )
                                          ],
                                          onPressed: (state) {
                                            setState(() {
                                              _toDoItemList[index].state =
                                                  state;
                                            });
                                          },
                                          color: Colors.black,
                                          renderBorder: false,
                                          borderColor: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          selectedColor: Colors.white,
                                          selectedBorderColor: Colors.white,
                                          fillColor: Color(0x22757575),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          _toDoItemList[index].comment,
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      )
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }, childCount: _toDoItemList.length),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
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
