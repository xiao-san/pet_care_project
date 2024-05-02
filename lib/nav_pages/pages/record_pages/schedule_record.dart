import 'dart:async';
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care_app/components/model/vaccines.dart';
import 'package:pet_care_app/components/widgets/input_field_list.dart';
import 'package:pet_care_app/utils/my_utils.dart';
import 'package:pet_care_app/utils/notification_services.dart';

class ScheduleRecords extends StatefulWidget {
  const ScheduleRecords({super.key});

  @override
  State<ScheduleRecords> createState() => _ScheduleRecordsState();
}

class _ScheduleRecordsState extends State<ScheduleRecords> {
  final List<Vaccines> _registerVaccine = [];
  bool _isLoading = false;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); // Initialize notification plugin
  late Timer _timer;
  final NotificationServices _notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    _loadData();
    // Start a timer to check for matching dates and times
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      // _sendNotifications();
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.https(
        'petcareapp-95b81-default-rtdb.firebaseio.com', 'schedule-data.json');
    final response = await http.get(url);

    if (response.body == 'null') {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      if (data.isNotEmpty) {
        data.forEach((key, value) {
          Map<String, dynamic> innerMap = value;
          //converting String into DateTime
          String id = key;
          String dateStr = innerMap['date'];
          DateTime date = DateTime.parse(dateStr);
          String name = innerMap['name'];
          String note = innerMap['note'];

          //convering String into TimeOfDay
          String timeStr = innerMap['time'];
          int startIndex = timeStr.indexOf('(') + 1;
          int endIndex = timeStr.indexOf(':');
          int hour = int.parse(timeStr.substring(startIndex, endIndex).trim());
          startIndex = endIndex + 1;
          endIndex = timeStr.indexOf(')');
          int minute =
              int.parse(timeStr.substring(startIndex, endIndex).trim());
          TimeOfDay time = TimeOfDay(hour: hour, minute: minute);

          _registerVaccine.add(Vaccines(
            id: id,
            date: date,
            name: name,
            note: note,
            time: time,
          ));

          // _showNotification(value);

          setState(() {
            _isLoading = false;
          });
        });
      }
    } else {
      throw Exception('Failed to load data from Firebase');
      // Set _isLoading to false after processing data
    }
  }

  // void _sendNotifications() {
  //   // Get the current date and time
  //   DateTime now = DateTime.now();

  //   // Loop through registered vaccines to check for matching dates and times
  //   // for (var vaccine in _registerVaccine) {
  //   //   if (vaccine.date!.year == now.year &&
  //   //       vaccine.date!.month == now.month &&
  //   //       vaccine.date!.day == now.day &&
  //   //       vaccine.time!.hour == now.hour &&
  //   //       vaccine.time!.minute == now.minute) {
  //   //     // Send notification for matching vaccine
  //   //     _showNotification(vaccine);
  //   //   }
  //   // }
  //    _showNotification(_registerVaccine[index]);

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Schedule Records',
            style: MyUtils.header,
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey,
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : InputFieldList(inputData: _registerVaccine));
  }
}
