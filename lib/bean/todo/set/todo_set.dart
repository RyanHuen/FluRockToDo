class ToDoSet {
  int id;
  String name;
  String belongEmail;
  bool enable;
  String createTimestamp;

  ToDoSet(
      {this.id,
      this.name,
      this.belongEmail,
      this.enable,
      this.createTimestamp});

  ToDoSet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    belongEmail = json['belong_email'];
    enable = json['enable'];
    createTimestamp = json['createTimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['belong_email'] = this.belongEmail;
    data['enable'] = this.enable;
    data['createTimestamp'] = this.createTimestamp;
    return data;
  }

  String parseDisplayTime() {
    DateTime time = DateTime.parse(createTimestamp);
    String display = time.year.toString() +
        "年" +
        time.month.toString() +
        "月" +
        time.day.toString() +
        "日 " +
        time.hour.toString() +
        "-" +
        time.minute.toString() +
        "-" +
        time.second.toString();
    return display;
  }
}
