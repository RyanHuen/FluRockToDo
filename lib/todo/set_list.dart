import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:rocktodo/bean/todo/set/todo_set.dart';
import 'package:rocktodo/common/theme.dart';
import 'package:rocktodo/net/rock_net.dart';
import 'package:rocktodo/todo/todo_item_list.dart';
import 'package:rocktodo/util/time_util.dart';

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
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 10,
                        top: 15,
                        right: 10,
                        bottom: index == _toDoSetList.length - 1 ? 15 : 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ToDoItemListWidget(
                                      todoSetId: _toDoSetList[index].id,
                                    )));
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
                        height: 80.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                child: Align(
                                  child: Text(
                                    _toDoSetList[index].name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF061B28)),
                                  ),
                                  alignment: Alignment.topLeft,
                                ),
                                padding: EdgeInsets.only(
                                    left: 15, top: 10, bottom: 0, right: 0),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  _toDoSetList[index].belongEmail,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 0, top: 0, bottom: 5, right: 20),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      TimeUtil.timeFormat(
                                          _toDoSetList[index].createTimestamp),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            )
                          ],
                        ),
                      ),
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
