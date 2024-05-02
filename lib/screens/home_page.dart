
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pet_care_app/utils/notification_services.dart';

import '../nav_pages/pages/main_page.dart';
import '../nav_pages/pages/profile_page.dart';
import '../nav_pages/pages/record_page.dart';
// import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // void setupPushNotification() async {
  //   final msg = FirebaseMessaging.instance;

  //   await msg.requestPermission();

  //   final token =await msg.getToken();
  //   print("Token :$token");
  // }
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    // ...
    // setupPushNotification();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseinit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices
        .getDeviceToken()
        .then((value) => {print('TOKEN ===>>'), print(value)});
  }

  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      // print(my)
    });
  }

  List<Widget> navPages = const [
    MainPage(),
    RecordPage(),
    // SettingsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text('Pet Care App'),
        centerTitle: true,
        actions: [
          // IconButton(
          //   onPressed: () {
          //     FirebaseAuth.instance.signOut();
          //   },
          //   icon: Icon(
          //     Icons.logout_outlined,
          //     color: Theme.of(context).colorScheme.primary,
          //   ),
          // ),
          const SizedBox(
            width: 20,
          ),
          // IconButton(
          //   onPressed: () async {
          //     // Send notification when button is clicked
          //     notificationServices.getDeviceToken().then((value) async {
          //       var data = {
          //         'to': value.toString(),
          //         'priority': 'high',
          //         'notification': {
          //           'title': 'Pet Care App',
          //           'body': 'Vaccinate your Pet',
          //         }
          //       };

          //       await http.post(
          //         Uri.parse('https://fcm.googleapis.com/fcm/send'),
          //         body: jsonEncode(data),
          //         headers: {
          //           'Content-Type': 'application/json; charset=UTF-8',
          //           'Authorization':
          //               'key=AAAAPbBIXBo:APA91bHhVHq4GAGOY4chQo5Bw5vywntHhmg8jr8Mmj0eSle9NYqXHxD9iisI0_JHnWEA-T2XFS9fxyyh500cleU20dPHdNqCafXR5FKM000X-KyIn453KfpCmiDZ1LiVOWM2KbAeps-m', // Replace with your FCM server key
          //         },
          //       ).then((response) {
          //         print('FCM Response: ${response.statusCode}');
          //         print('FCM Response Body: ${response.body}');
          //       }).catchError((error) {
          //         print('FCM Error: $error');
          //       });
          //     });
          //   },
          //   icon: Icon(
          //     Icons.notification_add_sharp,
          //     color: Theme.of(context).colorScheme.primary,
          //   ),
          // ),
        ],
      ),

      backgroundColor: Colors.blue,
      body: navPages[_selectedPageIndex],
      bottomNavigationBar: Container(
        color: Colors.grey.shade300,
        // height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: Colors.grey.shade300,
            tabBackgroundColor: Colors.deepPurple.shade200,
            gap: 8,
            padding: const EdgeInsets.all(16),
            onTabChange: _selectedPage,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.bar_chart_sharp,
                text: 'Report',
              ),
              // GButton(
              //   icon: Icons.settings,
              //   text: 'Settings',
              // ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
