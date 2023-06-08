// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class TextRecognitionPage extends StatefulWidget {
//   @override
//   _TextRecognitionPageState createState() => _TextRecognitionPageState();
// }
//
// class _TextRecognitionPageState extends State<TextRecognitionPage> {
//   late File _image;
//   List<String> searchList = ['word1', 'word2', 'word3'];
//   late String resultText;
//   bool showPopupImage = false;
//
//   Future getImageFromCamera() async {
//     var image = await ImagePicker().getImage(source: ImageSource.camera);
//     setState(() {
//       _image = File(image?.path);
//       resultText = null;
//       showPopupImage = false;
//     });
//     recognizeText();
//   }
//
//   Future recognizeText() async {
//     final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(_image);
//     final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
//     final VisionText visionText = await textRecognizer.processImage(visionImage);
//
//     String recognizedText = '';
//     for (TextBlock block in visionText.blocks) {
//       for (TextLine line in block.lines) {
//         for (TextElement element in line.elements) {
//           recognizedText += element.text + ' ';
//         }
//         recognizedText += '\n';
//       }
//     }
//     setState(() {
//       resultText = recognizedText;
//       if (searchList.any((word) => recognizedText.contains(word))) {
//         showPopupImage = true;
//       } else {
//         showPopupImage = false;
//       }
//     });
//     textRecognizer.close();
//   }
//
//   void resetScan() {
//     setState(() {
//       _image = null;
//       resultText = null;
//       showPopupImage = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Text Recognition'),
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         child: _image == null
//             ? Text('No image selected.')
//             : Column(
//           children: [
//             Expanded(
//               child: Image.file(_image),
//             ),
//             SizedBox(height: 20),
//             resultText == null
//                 ? CircularProgressIndicator()
//                 : Expanded(
//               child: SingleChildScrollView(
//                 child: Text(
//                   resultText,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: resetScan,
//               child: Text('New Scan'),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: getImageFromCamera,
//         tooltip: 'Take a photo',
//         child: Icon(Icons.camera_alt),
//       ),
//     );
//   }
// }
//
