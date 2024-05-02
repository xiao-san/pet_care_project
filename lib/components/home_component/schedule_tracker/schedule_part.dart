import 'package:flutter/material.dart';
import 'package:pet_care_app/components/home_component/schedule_tracker/schedule.dart';

  // Response? myResponse;

class SchedulePart extends StatefulWidget {
  const SchedulePart({super.key});

  @override
  State<SchedulePart> createState() => _SchedulePartState();
}

class _SchedulePartState extends State<SchedulePart> {
  List<String> scheduleNames = [
    'Vaccination',
    'Medication',
    'Vet Visit',
    'Care',
    'Symptoms',
    'Others'
  ];

  List<String> scheduleImg = [
    'images/scheduleimg/1.png',
    'images/scheduleimg/2.png',
    'images/scheduleimg/3.png',
    'images/scheduleimg/4.png',
    'images/scheduleimg/5.png',
    'images/scheduleimg/6.png',
  ];

  List<String> hintNames = [
    'Enter Vaccine Type',
    'Enter Medicine Type',
    'Enter Vet Visit',
    'Enter Care type',
    'Enter Symptoms',
    'Enter Others',
  ];

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = 3;
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 375) {
      crossAxisCount = 4;
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: GridView.builder(
        itemCount: 6,
        //  padding: EdgeInsets.all(5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => Column(
          children: [
            GestureDetector(
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => Schedule(
                                titleName: scheduleNames[0],
                                hintNames: hintNames[0],
                                myScheuleImg: scheduleImg[0],
                              )));
                } else if (index == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => Schedule(
                                titleName: scheduleNames[1],
                                hintNames: hintNames[1],
                                myScheuleImg: scheduleImg[1],
                              )));
                } else if (index == 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => Schedule(
                                titleName: scheduleNames[2],
                                hintNames: hintNames[2],
                                myScheuleImg: scheduleImg[2],
                              )));
                } else if (index == 3) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => Schedule(
                                titleName: scheduleNames[3],
                                hintNames: hintNames[3],
                                myScheuleImg: scheduleImg[3],
                              )));
                } else if (index == 4) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => Schedule(
                                titleName: scheduleNames[4],
                                hintNames: hintNames[4],
                                myScheuleImg: scheduleImg[4],
                              )));
                } else if (index == 5) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => Schedule(
                                titleName: scheduleNames[5],
                                hintNames: hintNames[5],
                                myScheuleImg: scheduleImg[5],
                              )));
                }
              },
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                height: 80,
                width: 80,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(scheduleImg[index]),
                    ),
                  ],
                ),
              ),
            ),
            Text(scheduleNames[index]),
          ],
        ),
      ),
    );
  }
}
