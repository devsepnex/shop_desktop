import 'package:shamsi_date/shamsi_date.dart';

String formatDate(int timestamp) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final jalaliDate = Jalali.fromDateTime(dateTime);
  return '${jalaliDate.year}/${jalaliDate.month}/${jalaliDate.day}';
}

String formatTime(int timestamp) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
}
