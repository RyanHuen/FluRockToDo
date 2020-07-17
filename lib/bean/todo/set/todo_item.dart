class ToDoList {
  String name;
  bool enable;
  String createTimestamp;
  List<ToDoItem> todoList;

  ToDoList(
      {this.name = '',
      this.enable = true,
      this.createTimestamp = '',
      this.todoList});

  ToDoList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    enable = json['enable'];
    createTimestamp = json['createTimestamp'];
    if (json['todo_list'] != null) {
      todoList = new List<ToDoItem>();
      json['todo_list'].forEach((v) {
        todoList.add(new ToDoItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['enable'] = this.enable;
    data['createTimestamp'] = this.createTimestamp;
    if (this.todoList != null) {
      data['todo_list'] = this.todoList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ToDoItem {
  String todoItemId;
  String createTimestamp;
  String modifyTimestamp;
  String notifyTimestamp;
  int state;
  String comment;
  String note;
  int sort;

  ToDoItem(
      {this.todoItemId,
      this.createTimestamp,
      this.modifyTimestamp,
      this.notifyTimestamp,
      this.state,
      this.comment,
      this.note,
      this.sort});

  ToDoItem.fromJson(Map<String, dynamic> json) {
    todoItemId = json['todo_item_id'];
    createTimestamp = json['createTimestamp'];
    modifyTimestamp = json['modifyTimestamp'];
    notifyTimestamp = json['notifyTimestamp'];
    state = json['state'];
    comment = json['comment'];
    note = json['note'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['todo_item_id'] = this.todoItemId;
    data['createTimestamp'] = this.createTimestamp;
    data['modifyTimestamp'] = this.modifyTimestamp;
    data['notifyTimestamp'] = this.notifyTimestamp;
    data['state'] = this.state;
    data['comment'] = this.comment;
    data['note'] = this.note;
    data['sort'] = this.sort;
    return data;
  }

  @override
  String toString() {
    return 'ToDoItem{todoItemId: $todoItemId, createTimestamp: $createTimestamp, modifyTimestamp: $modifyTimestamp, notifyTimestamp: $notifyTimestamp, state: $state, comment: $comment, note: $note, sort: $sort}';
  }
}
