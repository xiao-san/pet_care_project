import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:pet_care_app/components/model/vaccines.dart';
import 'package:http/http.dart' as http;

final formatter = DateFormat.yMMMd();

class Schedule extends StatefulWidget {
  const Schedule({
    super.key,
    required this.hintNames,
    required this.myScheuleImg,
    required this.titleName,
    // required this.getResponse,
  });

  final String myScheuleImg;
  final String titleName;
  final String hintNames;
  // final void Function(Response myRespone) getResponse;

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  TextEditingController myController = TextEditingController();
  TextEditingController myNoteController = TextEditingController();
  DateTime? mySelectedDate;
  TimeOfDay? mySelectedTime;
  //Cureent Date Picking
  void currentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    DateTime? pickedDate;

    pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      mySelectedDate = pickedDate;
    });
  }

//Current Time Picking
  void currentTimePicker() async {
    final now = TimeOfDay.now();
    TimeOfDay? pickedTime;

    pickedTime = await showTimePicker(
      context: context,
      initialTime: now,
    );

    setState(() {
      mySelectedTime = pickedTime;
    });
  }

  String selectedDogVaccine = "Rabies";
  String selectedCatVaccine = "Rabies";

  List<String> dogVaccines = [
    "Rabies",
    "Canine distemper",
    "Canine parvovirus",
    "Canine adenovirus type 1",
    "Canine adenovirus type 2",
    "Canine parainfluenza",
    "Leptospirosis",
    "Bordetella bronchiseptica",
    "Lyme disease",
    "Canine influenza",
  ];

  List<String> catVaccines = [
    "Rabies",
    "Feline viral rhinotracheitis ",
    "Feline calicivirus",
    "Feline panleukopenia",
    "Feline leukemia virus",
    "Feline immunodeficiency virus",
    "Chlamydophila felis",
  ];

  String?
      selectedVaccine; // Variable to store the selected vaccine (Making Global)

  void showVaccineType() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shadowColor: Colors.blueGrey,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel_outlined),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            // DOGS VACCINES ---------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            const Text(
              'Dog Vaccines:',
              style: TextStyle(fontSize: 16.0),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: "Select a dog's vaccine",
                ),
                value: selectedDogVaccine,
                onChanged: (value) {
                  setState(() {
                    selectedDogVaccine = value!;
                    selectedVaccine = value; // Update selected vaccine

                    // vaccineType.text = value; // Update TextField directly

                    //To show the selected vaccine
                    showShortDialog(value);
                  });
                },
                items: dogVaccines.map((vaccine) {
                  return DropdownMenuItem(
                    value: vaccine,
                    child: Text(vaccine),
                  );
                }).toList(),
              ),
            ),

            const Padding(padding: EdgeInsets.symmetric(vertical: 20)),

            // CATS VACCINES ---------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            const Text(
              'Cat Vaccines:',
              style: TextStyle(fontSize: 16.0),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: "Select a cat's vaccine",
                ),
                value: selectedCatVaccine,
                onChanged: (value) {
                  setState(() {
                    selectedCatVaccine = value!;
                    selectedVaccine = value; // Update selected vaccine

                    // vaccineType.text = value; // Update TextField directly
                    showShortDialog(value);
                  });
                },
                items: catVaccines.map((vaccine) {
                  return DropdownMenuItem(
                    value: vaccine,
                    child: Text(vaccine),
                  );
                }).toList(),
              ),
            ),

            // Save Button
            ElevatedButton(
                onPressed: () {
                  // Check if a vaccine is selected
                  if (selectedVaccine != null) {
                    myController.text = selectedVaccine!;
                    print('Selected Vaccine: $selectedVaccine');
                  } else {
                    print('No vaccine selected.');
                  }

                  print(myController.text);
                  print(myNoteController.text);
                  print(selectedCatVaccine);
                  print(selectedDogVaccine);
                },
                child: const Text('Save'))
          ],
        ),
      ),
    );
  }

  void showShortDialog(String selectedVaccineName) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing early
      builder: (context) => AlertDialog(
        title: const Text('Selected Vaccine'),
        content: Text("You've selected: $selectedVaccineName"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  //DATA MODEL
  // final List<Vaccines> _registerVaccine = [
  //   Vaccines(
  //       name: 'Kamal',
  //       date: DateTime.now(),
  //       time: TimeOfDay.now(),
  //       note: 'My Note'),
  //   Vaccines(
  //       name: 'FIML',
  //       date: DateTime.now(),
  //       time: TimeOfDay.now(),
  //       note: 'FUTTERS'),
  // ];

  void validateData() async {
    // final scheduleData = Vaccines(
    //   name: myController.text,
    //   date: mySelectedDate,
    //   time: mySelectedTime,
    //   note: myNoteController.text,
    // );

    // setState(() {
    //   _registerVaccine.add(scheduleData);  //accessing static list model
    // });

    
    //sendding data to firebase ->->->->->

    final url = Uri.https( 'petcareapp-95b81-default-rtdb.firebaseio.com', 'schedule-data.json');
    final responds = await http.post(url,
        headers: {'content-type': 'application/json'},
        body: json.encode({
          'name': myController.text,
          'date': mySelectedDate.toString(),
          'time': mySelectedTime.toString(),
          'note': myNoteController.text,
        }));

    print(responds.body);
    print(responds.statusCode);
    // widget.getResponse(responds);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       // builder: (builder) => ShowData(vaccine: _registerVaccine)),
    //       builder: (builder) => ShowData(vaccine: _registerVaccine)),
    // );
  }

  @override
  Widget build(BuildContext context) {
    String imagePath = widget.myScheuleImg;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleName),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),

              //fist circle Image
              CircleAvatar(
                backgroundImage: AssetImage(imagePath),
                radius: 30,
              ),
              const SizedBox(
                height: 20,
              ),

              //Second Textfield For Vaccine Type
              SizedBox(
                width: 300,
                child: TextField(
                  controller: myController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: widget.hintNames,
                    suffixIcon: widget.titleName == 'Vaccination'
                        ? IconButton(
                            onPressed: () {
                              showVaccineType();
                            },
                            icon: const Icon(Icons.search))
                        : null,
                  ),
                ),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text('Date & Time:'),
              //     TextButton(
              //       onPressed: () {
              //         _selectDateTime();
              //       },
              //       child: Text(_selectedDateTime?.toString() ?? 'Select'),
              //     ),
              //   ],
              // ),

              //Date Picker

              const SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      mySelectedDate == null
                          ? "Select a Date"
                          : formatter.format(mySelectedDate!),
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: currentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              //For Time Picker
              Container(
                width: 300,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      mySelectedTime == null
                          ? "Select a time"
                          : "${mySelectedTime!.hourOfPeriod == 0 ? 12 : mySelectedTime!.hourOfPeriod} : ${mySelectedTime!.minute.toString().padLeft(2, '0')} ${mySelectedTime!.period == DayPeriod.am ? 'AM' : 'PM'}",
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: currentTimePicker,
                      icon: const Icon(Icons.access_time_outlined),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              //Note Field
              SizedBox(
                width: 300,
                child: TextField(
                  controller: myNoteController,
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                  maxLength: 150,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Notes...',
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

//BACKEND___________________--------------___________-----------_________------>>>>>>>>>>>>>>>>>>>>>>>>>>>--->>/////
              ElevatedButton(
                  onPressed: () {
                    print(myController.text);

                    // print(_selectedDate);
                    print(formatter.format(mySelectedDate!)); //---------->

                    // print(widget.mySelectedTime);
                    print(
                        '${mySelectedTime!.hourOfPeriod}:${mySelectedTime!.minute} ${mySelectedTime!.period == DayPeriod.am ? "AM" : "PM"}');

                    print(myNoteController.text);

                    //Submit to save the data -->>>
                    validateData();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade400,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
