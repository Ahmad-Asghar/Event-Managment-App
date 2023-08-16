// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoPlayerPage extends StatefulWidget {
//   final VideoPlayerController videoPlayerController;
//
//   VideoPlayerPage({required this.videoPlayerController});
//
//   @override
//   _VideoPlayerPageState createState() => _VideoPlayerPageState();
// }
//
// class _VideoPlayerPageState extends State<VideoPlayerPage> {
//   late bool _isVideoPlaying;
//
//   @override
//   void initState() {
//     super.initState();
//     _isVideoPlaying = false;
//     widget.videoPlayerController.addListener(_videoEnded);
//     widget.videoPlayerController.initialize().then((_) {
//       setState(() {});
//     });
//   }
//
//   void _videoEnded() {
//     final position = widget.videoPlayerController.value.position;
//     final duration = widget.videoPlayerController.value.duration;
//
//     if (position >= duration) {
//       setState(() {
//         _isVideoPlaying = false;
//       });
//       print('Video ended');
//     }
//   }
//
//   void _playVideo() {
//     setState(() {
//       _isVideoPlaying = !_isVideoPlaying;
//       if (_isVideoPlaying) {
//         widget.videoPlayerController.play();
//       } else {
//         widget.videoPlayerController.pause();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.videoPlayerController.value.isInitialized) {
//       return SafeArea(
//         child: Scaffold(
//           backgroundColor: Colors.grey[900],
//           body: Center(
//             child: Container(
//               width: double.infinity,
//               child: AspectRatio(
//                 aspectRatio: widget.videoPlayerController.value.aspectRatio,
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     VideoPlayer(widget.videoPlayerController),
//                     IconButton(
//                       icon: Icon(
//                         _isVideoPlaying ? Icons.pause : Icons.play_arrow,
//                         size: 64.0,
//                         color: Colors.white,
//                       ),
//                       onPressed: _playVideo,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             child: Icon(Icons.arrow_back),
//             onPressed: () {
//               widget.videoPlayerController.pause();
//               Navigator.pop(context);
//             },
//           ),
//         ),
//       );
//     } else {
//       return Center(
//         child: CircularProgressIndicator(),
//       ); // or a loading indicator
//     }
//   }
// }
































// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// class AnimatedButton extends StatefulWidget {
//   @override
//   _AnimatedButtonState createState() => _AnimatedButtonState();
// }
//
// class _AnimatedButtonState extends State<AnimatedButton> {
//   // bool _expanded = false;
//   // int _value = 0;
//   //
//   // void _toggleExpand() {
//   //   setState(() {
//   //     _expanded = !_expanded;
//   //   });
//   // }
//   //
//   // void _increment() {
//   //   setState(() {
//   //     _value++;
//   //   });
//   // }
//   //
//   // void _decrement() {
//   //   setState(() {
//   //     if (_value > 0) {
//   //       _value--;
//   //     }
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           child:
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 // child: Container(
//                 //
//                 //   child: AnimatedContainer(
//                 //     decoration: BoxDecoration(
//                 //       borderRadius: BorderRadius.circular(50)
//                 //     ),
//                 //   duration: const Duration(milliseconds: 300),
//                 //   width: _expanded ? 70 : 30,
//                 //   height: 30,
//                 //   child: _expanded? GestureDetector(
//                 //     onTap: _toggleExpand,
//                 //     child: Container(
//                 //       decoration: BoxDecoration(
//                 //           color: Colors.orange,
//                 //         borderRadius: BorderRadius.circular(30)
//                 //       ),
//                 //
//                 //     ),
//                 //   ):GestureDetector(
//                 //     onTap: _toggleExpand,
//                 //     child: CircleAvatar(
//                 //       child: Icon(Icons.add),
//                 //     ),
//                 //   )
//                 // ),),
//                 child: Padding(
//                   padding: EdgeInsets.all(50),
//                     child: Lottie.asset("images/loading.json")),
//               )
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
