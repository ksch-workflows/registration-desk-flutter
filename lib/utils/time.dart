import 'package:equatable/equatable.dart';

class Date extends Equatable {
  final int year;
  final int month;
  final int day;

  const Date({required this.year, required this.month, required this.day});

  @override
  List<Object> get props => [year, month, day];
}

class Time extends Equatable {
  final int hour;
  final int minute;

  const Time({required this.hour, required this.minute});

  Time.fromDateTime(DateTime dateTime)
      : hour = dateTime.hour,
        minute = dateTime.minute;

  DateTime atDate(Date date) {
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  @override
  List<Object> get props => [hour, minute];

  bool get isBeforeNoon {
    return hour < 12;
  }

  @override
  String toString() {
    if (hour == 0 && minute == 0) {
      return '0:00 midnight';
    }
    if (hour == 24) {
      return '12:00 midnight';
    }

    var suffix = isBeforeNoon ? 'a.m.' : 'p.m.';
    var normalizedHour = hour <= 12 ? hour : hour % 12;
    var formattedHour = isBeforeNoon && normalizedHour < 10
        ? normalizedHour.toString().padLeft(2, '0')
        : normalizedHour.toString();
    var formattedMinute = minute.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute$suffix';
  }
}

extension DateTimeExtension on DateTime {
  String toFormattedString() {
    late String formattedDayOfWeek;
    switch (weekday) {
      case DateTime.monday:
        formattedDayOfWeek = 'Monday';
        break;
      case DateTime.tuesday:
        formattedDayOfWeek = 'Tuesday';
        break;
      case DateTime.wednesday:
        formattedDayOfWeek = 'Wednesday';
        break;
      case DateTime.thursday:
        formattedDayOfWeek = 'Thursday';
        break;
      case DateTime.friday:
        formattedDayOfWeek = 'Friday';
        break;
      case DateTime.saturday:
        formattedDayOfWeek = 'Saturday';
        break;
      case DateTime.sunday:
        formattedDayOfWeek = 'Sunday';
        break;
    }

    var formattedMonth = month.toString().padLeft(2, '0');
    var formattedDay = day.toString().padLeft(2, '0');
    var formattedDate = '$formattedDay-$formattedMonth-$year';

    var formattedTime = Time(hour: hour, minute: minute).toString();

    return '$formattedDayOfWeek, $formattedDate, $formattedTime';
  }
}
