import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Request permission to receive notifications
  void requestNotificationPermission() async {
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    print('Notification permission status: ${settings.authorizationStatus}');
  }

  // Check permission status
  void checkNotificationPermission() async {
    NotificationSettings settings =
        await _firebaseMessaging.getNotificationSettings();
    print('Notification permission status: ${settings.authorizationStatus}');
  }

  Future<String> getDeviceToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token!;
  }

    void firebaseinit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
        print(message.data.toString());
        print(message.data['type']);
        print(message.data['id']);
      }
      if (Platform.isAndroid) {
        initLocalNotification(context, message);
      } else {
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(10000).toString(), 'Alert pet infotmation',
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'My Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      // 'Alert pet infotmation',
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

    void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@drawable/logo.png');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: (payload) {
      handleMessage(context, message);
      // ...
    });
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
  if (message.data['type'] == 'notification') {
    // Extract notification content
    String title = message.notification?.title ?? '';
    String body = message.notification?.body ?? '';

    // Display notification content in console
    print('Received notification:');
    print('Title: $title');
    print('Body: $body');

  }
}

}


// import 'dart:io';
// import 'dart:math';

// import 'package:firebase_messaging/firebase_messaging.dart';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationServices {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   void requestNotificationPermission() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: true,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('user granted permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print('user granted provisional permission');
//     } else {
//       print('user denied permission');
//     }
//   }

//   void initLocalNotification(
//       BuildContext context, RemoteMessage message) async {
//     var androidInitializationSettings =
//         const AndroidInitializationSettings('@drawable/logo.png');
//     var iosInitializationSettings = const DarwinInitializationSettings();

//     var initializationSettings = InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );

//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveBackgroundNotificationResponse: (payload) {
//       handleMessage(context, message);
//       // ...
//     });
//   }

//   void firebaseinit(BuildContext context) {
//     FirebaseMessaging.onMessage.listen((message) {
//       if (kDebugMode) {
//         print(message.notification!.title.toString());
//         print(message.notification!.body.toString());
//         print(message.data.toString());
//         print(message.data['type']);
//         print(message.data['id']);
//       }
//       if (Platform.isAndroid) {
//         initLocalNotification(context, message);
//       } else {
//         showNotification(message);
//       }
//     });
//   }

//   Future<void> showNotification(RemoteMessage message) async {
//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//         Random.secure().nextInt(10000).toString(), 'Alert pet infotmation',
//         importance: Importance.max);

//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       channel.id.toString(),
//       channel.name.toString(),
//       channelDescription: 'My Channel Description',
//       importance: Importance.high,
//       priority: Priority.high,
//       ticker: 'ticker',
//       // 'Alert pet infotmation',
//     );

//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//     );

//     Future.delayed(Duration.zero, () {
//       _flutterLocalNotificationsPlugin.show(
//           0,
//           message.notification!.title.toString(),
//           message.notification!.body.toString(),
//           notificationDetails);
//     });
//   }

//   Future<String> getDeviceToken() async {
//     String? token = await messaging.getToken();
//     return token!;
//   }

//   Future<void> setupInteractMessage(BuildContext context) async {
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();

//     if (initialMessage != null) {
//       handleMessage(context, initialMessage);
//     }

//     FirebaseMessaging.onMessageOpenedApp.listen((event) {
//       handleMessage(context, event);
//     });
//   }

//   void handleMessage(BuildContext context, RemoteMessage message) {
//     if (message.data['type'] == 'notification') {}
//   }
// }
