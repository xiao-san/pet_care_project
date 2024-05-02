import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_care_app/components/model/vaccines.dart';
import 'dart:async'; //This package is for Time.periodic -->
import 'package:pet_care_app/utils/my_utils.dart';
import 'package:http/http.dart' as http;

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  var currentDate =
      DateTime.now(); //declaring now as a var (it is not constant variable)
  String selectedDate = "";
  String selectedTime = "";

  TimeFormat tf = TimeFormat();
  @override
  void initState() {
    super.initState();
    Timer.periodic(
        const Duration(seconds: 1),
        (timer) => setState(() {
              currentDate = DateTime.now(); // Update now within setState

              // var hour = now.hour; // Adjust for 12-hour format

              // var minute = now.minute;
              // var isPM = hour >= 12;

              // var newHour = hour; // Don't subtract 1 initially
              // if (hour > 12) {
              //   newHour = hour - 12;
              // }
              selectedDate = formatter.format(currentDate);

              selectedTime = tf.formattedTime;
            }));
  }

  //List of Activity
  List<String> activities = ['ate', 'drank', 'walk', 'sleep'];
  Set<String> selectedItems = {};

// Poop Count ------------------------->
  int countP = 0;
  void addPotty() {
    setState(() {
      countP++;
    });
  }

  void minusPotty() {
    setState(() {
      countP--;
    });
  }

// Pee count ------------------------->
  int countPee = 0;
  void addPee() {
    setState(() {
      countPee++;
    });
  }

  void minusPee() {
    setState(() {
      countPee--;
    });
  }

//----------------------------------->
  void displayDialog() {
    final myDate = '$selectedDate, $selectedTime';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selected Items'),
          content: Text(
              "${selectedItems.join(', ')}, 'Potty: $countP, Pee: $countPee, Date: $myDate"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okey'),
            ),
          ],
        );
      },
    );
  }

  void _submitData() async {
    // Check if selectedItems is empty
    if (selectedItems.isEmpty) {
      // Handle the case when no items are selected
      print('No items selected.');
      return;
    }

    //sendding data to firebase ->->->->->
    List<String> itemList = selectedItems.toList();
    final myDate = '$selectedDate, $selectedTime';

    // Handle null values for selected items
    String ate = 'false';
    String drank = 'false';
    String walk = 'false';
    String sleep = 'false';

    // Check if itemList contains specific items before accessing them
    if (itemList.contains('ate')) ate = 'ate';
    if (itemList.contains('drank')) drank = 'drank';
    if (itemList.contains('walk')) walk = 'walk';
    if (itemList.contains('sleep')) sleep = 'sleep';

    final url = Uri.https(
        'petcareapp-95b81-default-rtdb.firebaseio.com', 'activity-data.json');
    final responds = await http.post(url,
        headers: {'content-type': 'application/json'},
        body: json.encode({
          'activityDate': myDate,
          'ate': ate,
          'drank': drank,
          'walk': walk,
          'sleep': sleep,
          'pee': countPee,
          'potty': countP,
        }));
    print(responds.body);
    print(responds.statusCode);
  }

// A set to keep track of selected items  (it stores unique Elements No dublications)------------>

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Activity Record Tracker',
          style: MyUtils.header,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            //Date and TIme ----------------------->>>>>>>>>>>>>>>>>>>>>>>>>>
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Date:'),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Today, $selectedTime',
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(selectedDate),
                ),
              ],
            ),

            // CheckBox Buttons ---------------------------------------------------->
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.only(top: 20),
              height: 255,
              decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(20)),
              child: ListView.builder(
                itemCount: activities.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = activities[index];

                  //CheckBox
                  return CheckboxListTile(
                    title: Text(item),
                    secondary: Image.asset(
                      'images/activityimg/${index + 1}.png',
                      width: 50,
                      height: 50,
                    ),
                    value: selectedItems.contains(item),
                    onChanged: (value) {
                      setState(() {
                        if (value != null && value) {
                          selectedItems.add(item);
                        } else {
                          selectedItems.remove(item);
                        }
                      });
                    },
                  );
                },
              ),
            ),
//----------------------------------->>>>>>>>>>>>>>>>>>>>>
            // POTTY AND PEE COUNTER

            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                'Add Potty logs',
                style: TextStyle(fontSize: 24), // Use const for styles
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(8),
                  height: 50,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.shade100,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Image.asset(
                        'images/activityimg/poop.png',
                        height: 45,
                        width: 45,
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5)),
                      const Text('Potty'),
                      const Spacer(),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(5),
                  // padding: const EdgeInsets.all(20),
                  height: 50,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.shade100,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Image.asset(
                        'images/activityimg/pee.png',
                        height: 45,
                        width: 45,
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5)),
                      const Text('Pee'),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  // padding: const EdgeInsets.all(20),
                  height: 50,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.shade100,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (countP > 0) {
                              minusPotty();
                            }
                          },
                          icon: const Icon(Icons.remove),
                          // highlightColor: const Color.fromARGB(255, 97, 90, 90),
                          iconSize: 18,
                        ),
                        Text(
                          countP.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          onPressed: () {
                            if (countP < 20) {
                              addPotty();
                            }
                          },
                          icon: const Icon(Icons.add),
                          // highlightColor: Colors.red.shade200,
                          iconSize: 18,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  // padding: const EdgeInsets.all(20),
                  height: 50,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.shade100,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (countPee > 0) {
                            minusPee();
                          }
                        },
                        icon: const Icon(Icons.remove),
                        // highlightColor: Colors.deepOrangeAccent,
                        iconSize: 18,
                      ),
                      Text(
                        countPee.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        onPressed: () {
                          if (countPee < 20) {
                            addPee();
                          }
                        },
                        icon: const Icon(Icons.add),
                        // highlightColor: Colors.red.shade200,
                        iconSize: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                displayDialog();
                _submitData();
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple),
              child: const Text('Save Potty'),
            ),
          ],
        ),
      ),
    );
  }
}
