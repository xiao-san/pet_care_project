import 'package:flutter/material.dart';
import 'package:pet_care_app/components/home_component/read_more/dog_info.dart';

class ReadMore extends StatelessWidget {
  const ReadMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Pet Information'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            //Dog Container------>>>>>>>>___------->>>>>>____---------->>>>>
            Container(
              // alignment: Alignment.center,
              height: 100,
              width: 300,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('images/intro_images/4.png'),
                    maxRadius: 40,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dog Information',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const DogInfo()));
                        },
                        // style: TextButton.styleFrom(
                        //   backgroundColor: Colors.deepPurple.shade300,
                        // ),
                        child: const Text(
                          'Read About Dogs',
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chevron_right_sharp,
                        size: 40,
                      ))
                ],
              ),
            ),

            //Cat Container------>>>>>>>>___------->>>>>>____---------->>>>>
            Container(
              // alignment: Alignment.center,
              height: 100,
              width: 300,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('images/intro_images/5.png'),
                    maxRadius: 40,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cat Information',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        // style: TextButton.styleFrom(
                        //   backgroundColor: Colors.deepPurple.shade300,
                        // ),
                        child: const Text(
                          'Read About Cats',
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.chevron_right_sharp,
                      size: 40,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
