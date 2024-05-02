import 'package:flutter/material.dart';
import 'package:pet_care_app/components/home_component/activity_tracker/activity.dart';
import 'package:pet_care_app/components/home_component/read_more/read_more.dart';


class ActivityPart extends StatelessWidget {
  const ActivityPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 90),
      height: 200,
      width: 300,
      decoration: BoxDecoration(
      color: Colors.white,
        border: Border.all(color: Colors.grey)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Daily Activity Record Tracker',
            style: TextStyle(
              fontSize: 20,
              // color: Colors.white
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // read more section
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=> const ReadMore()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade400,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Read'),
              ),
              const Spacer(),
              const Text(
                'Add Records',
                style: TextStyle(
                    // color: Colors.white
                    ),
              ),
              const Padding(padding: EdgeInsets.only(left: 7)),
              FloatingActionButton(
                mini: true,
                backgroundColor: Colors.deepPurple.shade400,
                foregroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) =>
                              const Activity()));
                },
                child: const Icon(Icons.add,),
              ),
            ],
          )
        ],
      ),
    );
  }
}
