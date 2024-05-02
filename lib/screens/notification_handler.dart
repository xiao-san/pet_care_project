// import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:http/http.dart' as http;

// class NotificationnHandler {
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;

//   Future<void> sendNotification(String title, String body) async {
//     // Replace with your actual server key (obtained from Firebase console)
//     const String serverKey = 'YOUR_SERVER_KEY';

//     // Create notification payload
//     final message = {
//       'notification': {'title': title, 'body': body},
//       'priority': 'high', // Adjust priority as needed
//       'data': {'click_action': 'FLUTTER_NOTIFICATION_CLICK'}, // Optional data
//     };

//     // Send notification request using server key for authentication
//     await http.post(
//       Uri.parse('https://fcm.googleapis.com/fcm/send'),
//       body: jsonEncode(message),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'key=$serverKey',
//       },
//     );
//   }
// }