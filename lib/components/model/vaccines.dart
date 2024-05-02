import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMMMd();

class Vaccines {
  Vaccines({
    // required this.id,
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.note,
  });
  final String id;
  final String name;
  final DateTime? date;
  final TimeOfDay? time;
  final String note;

  String get formattedTime {

    String period = time!.period == DayPeriod.am ? 'AM' : 'PM';
    int hour = time!.hourOfPeriod == 0 ? 12 : time!.hourOfPeriod;
    return '$hour : ${time!.minute.toString().padLeft(2, '0')} $period';
  }
  String get formattedDate {
    return formatter.format(date!);
  }

}


class TimeFormat {

   String get formattedTime {
      var time = TimeOfDay.now();

    String period = time.period == DayPeriod.am ? 'AM' : 'PM';
    int hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    return '$hour : ${time.minute.toString().padLeft(2, '0')} $period';
  }
}
