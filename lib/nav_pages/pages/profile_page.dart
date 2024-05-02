
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:pet_care_app/components/pet_details/pet_input.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // String petName = controllerName.text;
  String? imageUrl;
  final FirebaseStorage storage =
      FirebaseStorage.instance; // Initialize storage
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? logoImage;
  String? petImage;

  @override
  void initState() {
    super.initState();
    // loadImageUrl();
    _getPetImageUrl();
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

  // Future<void> loadImageUrl() async {
  //   // final imagePicker = ImagePicker();
  //   // final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

  //   // setState(() {
  //   //   if (pickedFile != null) {
  //   //     pickedImage = pickedFile;
  //   //   }
  //   // });

  //   try {
  //     // Get reference to the image file
  //     Reference ref = FirebaseStorage.instance.ref().child('logo/logo.png');

  //     // Get the download URL
  //     String url = await ref.getDownloadURL();

  //     setState(() {
  //       imageUrl = url;
  //     });
  //   } catch (e) {
  //     // Handle any errors
  //     print('Error getting download URL: $e');
  //   }
  // }

  // String petBreed() {
  //   if (selectedPetType == "Dog") {
  //     return selectedDogBreed;
  //   } else {
  //     return selectedCatBreed;
  //   }
  // }

  TextEditingController newPetName = TextEditingController();
  String petName ="";

  void changePetName() {
    setState(() {
      petName = newPetName.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    void editPetName() {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.white,
          child: SizedBox(
            height: 160,
            width: double.maxFinite,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                      margin: const EdgeInsets.only(
                        left: 30,
                        top: 20,
                        bottom: 20,
                      ),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: newPetName,
                        decoration: const InputDecoration(
                          hintText:  "Enter Pet's name",
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      changePetName();
                    },
                    child: const Text('Save Name')),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(),
      body: Center(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(45),
              child: petImage != null ?Image.network(
                //................
                '$petImage',
                height: 150,
                width: 150,
              ) : const CircularProgressIndicator(),
            ),

            // ClipRRect(
            //     borderRadius: BorderRadius.circular(100),
            //     child: Image.file(
            //       File(pickedImage!.path),
            //       width: 150,
            //       height: 150,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  petName.isEmpty ? 'Enter a name':
                  petName,
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                    onPressed: () {
                      editPetName();
                    },
                    icon: const Icon(Icons.edit))
              ],
            ),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const PetInput()));
                },
                child: const Text('Enter Pet Information')),

            TextButton.icon(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
