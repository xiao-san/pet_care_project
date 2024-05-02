import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_app/screens/notification.dart';
import 'package:http/http.dart' as http;

String getPetName = "";
String getPetType = "";
String getPetBreed = "";
List<String> getPetData = [];

class ProfilePart extends StatefulWidget {
  const ProfilePart({
    super.key,
  });

  @override
  State<ProfilePart> createState() => _ProfilePartState();
}

class _ProfilePartState extends State<ProfilePart> {
  // final String imagePath;

  final FirebaseStorage storage =
      FirebaseStorage.instance; // Initialize storage
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? petImage;
  int profilePetName = 0;

  @override
  void initState() {
    super.initState();
    getPetDetails();
    _getPetImageUrl();
  }

  void getPetDetails() async {
    final url = Uri.https(
        'petcareapp-95b81-default-rtdb.firebaseio.com', 'pet-details.json');
    final response = await http.get(url);

    print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      data.forEach((key, value) {
        getPetName = value['pet_name'];
        getPetType = value['pet_type'];
        getPetBreed = value['pet_breed'];
        getPetData.add(getPetName);
        print(getPetData);
        print(getPetName);
        print(getPetType);
        print(getPetBreed);
      });
    }
  }

  Future<void> _getPetImageUrl() async {
    try {
      //getting petImage url
      final User? user = auth.currentUser;
      final imageRef =
          storage.ref().child('user_images').child('${user!.uid}.jpg');
      final url = await imageRef.getDownloadURL();
      print('SUCCESSS: $url');

      setState(() {
        petImage = url;
      });
    } catch (error) {
      print('Error fetching image URL from storage: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    void showProfilePage() {
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          height: 700,
        ),
      );
    }

    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(10),
        height: 150,
        color: Colors.grey.shade200,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(45),
              child: petImage != null
                  ? Image.network(
                      //................
                      '$petImage',
                      height: 50,
                      width: 50,
                    )
                  : const CircularProgressIndicator(),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
            Text(getPetData[getPetData.length-1]),
            IconButton(
                onPressed: showProfilePage,
                icon: const Icon(Icons.arrow_downward)),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationPage()));
              },
              icon: const Icon(
                Icons.notification_add_outlined,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
