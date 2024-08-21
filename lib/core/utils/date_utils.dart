String getDayOfWeek(String timestampStr) {
  int timestamp = int.parse(timestampStr);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  int weekday = date.weekday;

  const daysOfWeek = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
  return daysOfWeek[weekday - 1];
}

String formatDateFromTimestamp(int timestamp,
    {bool formatDateAndTime = false}) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  int day = date.day;
  String month = months[date.month - 1];
  int year = date.year;
  int hour = date.hour;
  int minute = date.minute;

  if(!formatDateAndTime) {
    return '$day $month $year';
  }
  return '$day $month $year $hour:$minute';
}

String getTimeFromTimeStamp(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return "${date.hour}:${date.minute}";
}

int getMinuteFromTimeStamp(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return date.hour * 60 + date.minute;
}

int getMinuteFromCurrentTime() {
  DateTime date = DateTime.now();
  return date.hour * 60 + date.minute;
}

String formatTimezone(int seconds) {
  int hours = seconds ~/ 3600;
  int minutes = (seconds.abs() % 3600) ~/ 60;
  String sign = seconds >= 0 ? '+' : '-';
  return '$sign${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}

String fahrenheitToCelsius(double fahrenheit) {
  return ((fahrenheit - 32) * 5 / 9).toString();
}

String kelvinToCelsius(num kelvin) {
  return (kelvin - 273.12).toStringAsFixed(1);
}
