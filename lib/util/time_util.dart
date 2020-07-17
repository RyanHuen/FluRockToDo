class TimeUtil {
  static String timeFormat(String timeString) {
    if (timeString == null || timeString.isEmpty) {
      return "";
    }
    DateTime time = DateTime.parse(timeString);
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
