import 'package:flutter/material.dart';
import 'package:pet_care_app/utils/my_utils.dart';

class VetVisit extends StatefulWidget {
  const VetVisit({super.key});

  @override
  State<VetVisit> createState() => _VetVisitState();
}

class _VetVisitState extends State<VetVisit> {

 

  List<String> doctorNames = [
    'Dr. Ram Chauhan',
    'Dr. Sachit Yadav',
    'Dr. Roman Prashad Thapa',
    'Dr. Arjun Shah',
  ];

  List<String> vType = [
    'Dog',
    'Cat',
    'Cat',
    'Dog',
  ];

  List<String> availableTime = [
    'SUN-TUE , 10:00 AM- 04:00 PM',
    'MON-WED , 10:00 AM- 04:00 PM',
    'WED-FRI , 10:00 AM- 04:00 PM',
    'SAT-THU , 10:00 AM- 04:00 PM',
  ];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Vet Visit'),
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (ctx, index) => Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          height: 130,
          width: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.green,
          ),
          child: Column(
            children: [
              //doctor name
              Row(
                children: [
                  const Text('Doctor Name :'),
                  Expanded(
                    child: Text(doctorNames[index]),
                  ),
                ],
              ),

              //Vetarinary Type
              Row(
                children: [
                  const Text('Vetarinary Type :'),
                  Expanded(
                    child: Text(vType[index]),
                  ),
                ],
              ),

              //Available Time
              Row(
                children: [
                  const Text('Available Time :'),
                  Expanded(
                    child: Text(availableTime[index]),
                  ),
                ],
              ),

              //show data
              ElevatedButton(onPressed: () {
                if(index == 0) {
                  myDialogBox(context, 9810449845, );
                }
                else if(index ==1) {
                  myDialogBox(context, 9812338903);
                }
                else if(index ==2) {
                  myDialogBox(context, 9815432199);
                }
                else if(index ==3) {
                  myDialogBox(context, 9804524409);
                }
              }, child: const Text('Show Data'))
            ],
          ),
        ),
      ),
    );
  }
}
