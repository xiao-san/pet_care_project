import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});


  @override
  Widget build(BuildContext context) {
    List<String> names = [
  'Emma',
  'Liam',
  'Olivia',
  'Noah',
  'Ava',
  'William',
  'Sophia',
  'James',
  'Isabella',
  'Oliver',
  'Mia',
  'Benjamin',
  'Charlotte',
  'Elijah',
  'Amelia',
  'Lucas',
  'Harper',
  'Mason',
  'Evelyn',
  'Logan',
];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (ctx, index) => Card(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          
        child: Text(names[index]),
      )),
    );
  }
}
