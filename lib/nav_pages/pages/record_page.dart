import 'package:flutter/material.dart';
import 'package:pet_care_app/nav_pages/pages/record_pages/activity_records.dart';
import 'package:pet_care_app/nav_pages/pages/record_pages/schedule_record.dart';
import 'package:pet_care_app/utils/my_utils.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // Scheudle Result Containn
            InkWell(
              onTap: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const AcitivityRecords()));
              },
              child: Container(
                alignment: Alignment.centerLeft,
                height: 200,
                width: 200,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'images/scheduleimg/daily_record.png',
                        height: 120,
                        width: 120,
                      ),
                      const Spacer(),
                      Text(
                        'Activity Records',
                        style: MyUtils.body,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const ScheduleRecords()));
              },
              child: Container(
                alignment: Alignment.centerLeft,
                height: 200,
                width: 200,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'images/scheduleimg/schedule_record.png',
                        height: 120,
                        width: 120,
                      ),
                      const Spacer(),
                      Text(
                        'Schedule Records',
                        style: MyUtils.body,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
