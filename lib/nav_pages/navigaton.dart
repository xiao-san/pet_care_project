// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:pet_care_app/nav_pages/pages/home_page.dart';
// import 'package:pet_care_app/nav_pages/pages/record_page.dart';
// import 'pages/profile_page.dart';
// import 'pages/settings_page.dart';

// int selectedIndex = 0;

// class NavigationPage extends StatefulWidget {
//   const NavigationPage({super.key});

//   @override
//   State<NavigationPage> createState() => _NavigationPageState();
// }

// class _NavigationPageState extends State<NavigationPage> {
//   final navPages = const [
//     // HomePage(),
//     RecordPage(),
//     SettingsPage(),
//     ProfilePage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('AppBar'),
//       ),
//       backgroundColor: Colors.blue,
//       body: navPages[selectedIndex],
//       bottomNavigationBar: Container(
//         color: Colors.grey.shade300,
//         // height: 100,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//           child: GNav(
//             backgroundColor: Colors.grey.shade300,
//             tabBackgroundColor: Colors.deepPurple.shade200,
//             gap: 8,
//             padding: const EdgeInsets.all(16),
//             onTabChange: (index) {
//               setState(() {
//                 selectedIndex = index;
//               });
//             },
//             tabs: const [
//               GButton(
//                 icon: Icons.home,
//                 text: 'Home',
//               ),

//               GButton(
//                 icon: Icons.bar_chart_sharp,
//                 text: 'Report',
//               ),
              
//               GButton(
//                 icon: Icons.settings,
//                 text: 'Settings',
//               ),
              
//               GButton(
//                 icon: Icons.person,
//                 text: 'Profile',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
