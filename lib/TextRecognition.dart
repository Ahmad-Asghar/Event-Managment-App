// import 'package:e_commerce/videoplayer.dart';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:video_player/video_player.dart';
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//
// class VideoPickerScreen extends StatefulWidget {
//   const VideoPickerScreen({Key? key}) : super(key: key);
//
//   @override
//   _VideoPickerScreenState createState() => _VideoPickerScreenState();
// }
//
// class _VideoPickerScreenState extends State<VideoPickerScreen> {
//   VideoPlayerController? _videoPlayerController;
//   bool _isVideoPlaying = false;
//   File? _videoFile;
//
//   Future<void> _pickVideo() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.video,
//       allowMultiple: false,
//     );
//
//     if (result != null) {
//       _videoFile = File(result.files.single.path!);
//       _videoPlayerController = VideoPlayerController.file(_videoFile!);
//       await _videoPlayerController!.initialize();
//       setState(() {
//         _isVideoPlaying = false;
//       });
//     }
//   }
//
//   Future<void> _uploadVideo() async {
//     if (_videoFile != null) {
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       firebase_storage.Reference storageRef =
//       firebase_storage.FirebaseStorage.instance.ref("Videos").child(fileName);
//       firebase_storage.UploadTask uploadTask = storageRef.putFile(_videoFile!);
//       await uploadTask.whenComplete(() => null);
//       String videoUrl = await storageRef.getDownloadURL();
//       // Do something with the video URL (e.g., save to database)
//       print('Video uploaded: $videoUrl');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Video Picker'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: _pickVideo,
//               child: const Text('Pick Video'),
//             ),
//             SizedBox(height: 16.0),
//             if (_videoPlayerController != null)
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => VideoPlayerPage(
//                           videoPlayerController: _videoPlayerController!,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     height: 30.h,
//                     width: double.infinity,
//                     child: AspectRatio(
//                       aspectRatio: _videoPlayerController!.value.aspectRatio,
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           VideoPlayer(_videoPlayerController!),
//                           IconButton(
//                             icon: Icon(
//                               _isVideoPlaying
//                                   ? Icons.pause
//                                   : Icons.play_arrow,
//                               size: 64.0,
//                               color: Colors.white,
//                             ),
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => VideoPlayerPage(
//                                     videoPlayerController:
//                                     _videoPlayerController!,
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _uploadVideo,
//               child: Text('Upload Video'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
