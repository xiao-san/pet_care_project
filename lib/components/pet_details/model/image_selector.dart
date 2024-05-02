// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

//   XFile? pickedImage;
// class ImageSelection extends StatefulWidget {
//   const ImageSelection({super.key});

//   @override
//   State<ImageSelection> createState() => _ImageSelectionState();
// }

// class _ImageSelectionState extends State<ImageSelection> {

//   Future<void> _getImage() async {
//     final imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         pickedImage = pickedFile;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: 200,
//         height: 200,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.red),
//           borderRadius: BorderRadius.circular(100),
//         ),
//         child: pickedImage == null
//             ? SizedBox(
//                 child: TextButton(
//                   onPressed: () {
//                     _getImage();
//                   },
//                   child: const Center(child: Text('Select')),
//                 ),
//               )
//             : ClipRRect(
//                 borderRadius: BorderRadius.circular(100),
//                 child: Image.file(
//                   File(pickedImage!.path),
//                   width: 200,
//                   height: 200,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//       ),
//     );
//   }
// }
