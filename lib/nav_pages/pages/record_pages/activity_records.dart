import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pet_care_app/components/model/activity_model.dart';
import 'package:pet_care_app/utils/my_utils.dart';
import 'package:http/http.dart' as http;

class AcitivityRecords extends StatefulWidget {
  const AcitivityRecords({super.key});

  @override
  State<AcitivityRecords> createState() => _AcitivityRecordsState();
}

class _AcitivityRecordsState extends State<AcitivityRecords> {
  bool isLoading = false;
  List<Activites> activityData = [
    // const Activites(
    //   id: 'sadas',
    //   activityDate: '2023/5/9, 10:50 AM',
    //   ate: 'ate',
    //   drank: 'false',
    //   walk: 'walk',
    //   sleep: 'false',
    //   potty: 45,
    //   pee: 4,
    // ),
    // const Activites(
    //   id: 'sdfsd',
    //   activityDate: '2023/5/9, 10:51 AM',
    //   ate: 'ate',
    //   drank: 'false',
    //   walk: 'walk',
    //   sleep: 'sleep',
    //   potty: 4,
    //   pee: 5,
    // ),
    // const Activites(
    //   activityDate: '2023/5/9, 10:52 AM',
    //   ate: 'false',
    //   drank: 'drank',
    //   walk: 'walk',
    //   sleep: 'false',
    //   potty: '2',
    //   pee: '5',
    // ),
    // const Activites(
    //   activityDate: '2023/5/9, 10:53 AM',
    //   ate: 'ate',
    //   drank: 'drank',
    //   walk: 'false',
    //   sleep: 'false',
    //   potty: '12',
    //   pee: '38',
    // ),
    // const Activites(
    //   activityDate: '2023/5/9, 10:54 AM',
    //   ate: 'ate',
    //   drank: 'drank',
    //   walk: 'walk',
    //   sleep: 'sleep',
    //   potty: '100',
    //   pee: '500',
    // ),
  ];

  List<Activites> filteredActivityData = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  // fetching data from the backend
  void getData() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.https(
        'petcareapp-95b81-default-rtdb.firebaseio.com', 'activity-data.json');
    final response = await http.get(url);
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        data.forEach((key, value) {
          // print("Value: $value");
          //activies value
          print("activityData => ${value['activityData']}");
          print("ate=> ${value['ate']}");
          print("drank=> ${value['drank']}");
          print("walk=> ${value['walk']}");
          print("sleep=> ${value['sleep']}");
          print("pee=> ${value['pee']}");
          print("potty=> ${value['potty']}");

          activityData.add(
            Activites(
              id: key,
              activityDate: value['activityDate'] ?? '',
              ate: value['ate'] ?? '',
              drank: value['drank'] ?? '',
              walk: value['walk'] ?? '',
              sleep: value['sleep'] ?? '',
              potty: value['pee'] ?? '',
              pee: value['potty'] ?? '',
            ),
          );
        });
        isLoading = false;
      });
    } else {
      print("Backend fetch data failed...");
    }
  }

  void _deleteActivity(Activites data) async {
    final url = Uri.https(
      'petcareapp-95b81-default-rtdb.firebaseio.com',
      'activity-data/${data.id}.json',
    );

    final response = await http.delete(url);
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        activityData.remove(data);
      });
      print('Successfully deleted activity data.');
    } else {
      print('Error deleting activity: ${response.statusCode}');
    }
  }

  void searchByDate(String date) {
    setState(() {
      filteredActivityData = activityData
          .where((activity) =>
              activity.activityDate.toLowerCase().contains(date.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Activity Records',
            style: MyUtils.header,
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey,
        body: Column(
          //search Button
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(6.0),
              color: Colors.white,
              child: TextField(
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  searchByDate(value);
                },
                decoration: InputDecoration(
                  labelText: 'Search by Date (e.g. YYYY/MM/DD)',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ),
            isLoading
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: ListView.builder(
                      itemCount: activityData.length,
                      itemBuilder: (ctx, index) => Dismissible(
                        key: GlobalKey(),
                        onDismissed: (direction) {
                          _deleteActivity(activityData[index]);
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete_forever,
                              color: Colors.white, size: 28),
                        ),
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          child: ListTile(
                            selectedColor: Colors.tealAccent,
                            title: Center(
                              child: Column(
                                children: [
                                  Text(
                                    activityData[index].activityDate,
                                    style: MyUtils.body,
                                  ),
                                  const Divider(
                                    thickness: 3,
                                  ),
                                ],
                              ),
                            ),

                            //sub title items
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'ATE ',
                                            style: MyUtils.body,
                                          ),
                                          //  const SizedBox(width: 10,),
                                          const Spacer(),
                                          Container(
                                            width: 20,
                                            height: 20,
                                            color: activityData[index].ate ==
                                                    'false'
                                                ? Colors.red
                                                : Colors.green,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'DRANK',
                                            style: MyUtils.body,
                                          ),
                                          const Spacer(),
                                          Container(
                                            width: 20,
                                            height: 20,
                                            color: activityData[index].drank ==
                                                    'false'
                                                ? Colors.red
                                                : Colors.green,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'SLEEP',
                                            style: MyUtils.body,
                                          ),
                                          const Spacer(),
                                          Container(
                                            width: 20,
                                            height: 20,
                                            color: activityData[index].sleep ==
                                                    'sleep'
                                                ? Colors.green
                                                : Colors.red,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'WALK',
                                            style: MyUtils.body,
                                          ),
                                          const Spacer(),
                                          Container(
                                            width: 20,
                                            height: 20,
                                            color: activityData[index].walk ==
                                                    'false'
                                                ? Colors.red
                                                : Colors.green,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'PEE',
                                            style: MyUtils.body,
                                          ),
                                          const Spacer(),
                                          Text(
                                            activityData[index].pee.toString(),
                                            style: MyUtils.body,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'POOTY',
                                            style: MyUtils.body,
                                          ),
                                          const Spacer(),
                                          Text(
                                            activityData[index]
                                                .potty
                                                .toString(),
                                            style: MyUtils.body,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ));
  }
}
