


List<String> formatDate(DateTime date) {
  List<String> dateList = [];
  String day = date.day.toString().padLeft(2, '0');
  String month = date.month.toString().padLeft(2, '0');
  String year = date.year.toString();
  dateList.add(day);
  dateList.add(month);
  dateList.add(year);
  return dateList;
}


List<String> formatTime(DateTime time) {
  List<String> timeList = [];
  String hour = time.hour.toString().padLeft(2, '0');
  String minute = time.minute.toString().padLeft(2, '0');
  timeList.add(hour);
  timeList.add(minute);
  return timeList;
}
