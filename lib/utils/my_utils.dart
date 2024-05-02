import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

 void myDialogBox(BuildContext context , int num) {
    // List<int> numbers = [9810449845, 9812338903, 9815432199, 9804524409];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Contact'),
          content: Text(num.toString()),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okay'),
            ),
          ],
        );
      },
    );
  }

class MyUtils {
  static TextStyle get body => GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get header => GoogleFonts.lato(
        fontSize: 24,
        fontWeight: FontWeight.w500,
      );

 
}
