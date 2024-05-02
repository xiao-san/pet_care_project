import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseStorage storage =
      FirebaseStorage.instance; // Initialize storage
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? logoImage;
  String? petImage;

  @override
  void initState() {
    super.initState();
    _getImageUrl(); // Call the function to fetch the image URL on initialization
    _getPetImageUrl();
  }

  Future<void> _getImageUrl() async {
    try {
      // Create reference within Firebase Storage bucket
      final imageRef = storage.ref().child('Logo/logo.png');
      print(imageRef);

      // Get the download URL with async/await
      final url = await imageRef.getDownloadURL();
      print('logo: $url');

      setState(() {
        logoImage = url;
      }); 
      //     setState(() {
      //   petImage = imageUrl;
      // });
    } catch (error) {
      // Handle errors
      print('Error fetching image URL from storage: $error');
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
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        children: [
          Center(
            child: logoImage != null
                ? Image.network(logoImage!) // Display image if URL is available
                : const CircularProgressIndicator(), // Show a progress indicator while loading
          ),
          Center(
            child: petImage != null
                ? Image.network(petImage!,width: 100,height: 100,) // Display image if URL is available
                : const CircularProgressIndicator(), // Show a progress indicator while loading
          ),
        ],
      ),
    );
  }
}
