import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce/Models/Event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import '../../Controller/Event_controllers/Join_Event.dart';
import '../../Controller/Event_controllers/delete_Event.dart';
import '../../Controller/Event_controllers/upload_videos.dart';
import '../../Models/UserModel.dart';
import '../../Widgets/DialougeBox.dart';
import 'ViewJoinedUsers.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EventDetails extends StatefulWidget {
  final String eventId;
  final UserModel userModel;
  final User firebaseuser;
  const EventDetails(
      {Key? key,
      required this.eventId,
      required this.userModel,
      required this.firebaseuser})
      : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>> eventStream;
  JoinedUsers ju = JoinedUsers();

  File? _video;
  VideoPlayerController? _videoPlayerController;
  Future<void> _selectVideo() async {
    final pickedFile =
        await ImagePicker().getVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
      });
    }
  }
  Future<void> _uploadVideo(String eventID) async {
    if (_video != null) {
      showWaitingDialouge(context);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref("Event Videos")
          .child(fileName);
      firebase_storage.UploadTask uploadTask = storageRef.putFile(_video!);
      await uploadTask.whenComplete(() => null);
      String videoUrl = await storageRef.getDownloadURL();

      uploadVideo(videoUrl, eventID, context);
      setState(() {
        //_video=null;
      });
      print('Video uploaded: $videoUrl');
    }
  }
  @override
  void initState() {
    super.initState();
    eventStream = FirebaseFirestore.instance
        .collection('Events')
        .doc(widget.eventId)
        .snapshots();
  }
  String timeFormat(String time) {
    String? createdTimeString = time;
    DateTime createdTime = DateTime.parse(createdTimeString!);
    String formattedDate = DateFormat('dd MMMM').format(createdTime);
    String formattedTime =
        DateFormat('hh:mma').format(createdTime).toLowerCase();
    String finalFormat = '$formattedDate $formattedTime';
    return finalFormat;
  }
  String extractTime(String timeString) {
    final startIndex = timeString.indexOf('(') + 1;
    final endIndex = timeString.indexOf(')');
    return timeString.substring(startIndex, endIndex);
  }
  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('d MMMM').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: eventStream,
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return Text('No data available');
            }

            final data = snapshot.data!.data();
            final event = Event.fromMap(data!);

            String eventCreatedTime =
                timeFormat(event.eventCreatedTime.toString());
            String eventStartTime = extractTime(event.startTime.toString());
            String eventStartDate = formatDate(event.dateTime.toString());
            int maxAllowed = int.parse(event.maxEntries.toString());
            int joined = int.parse((event.joined?.length ?? '').toString());
            String remainings = (maxAllowed - joined).toString();

            return Container(
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_circle_left_outlined,
                                size: 5.h,
                              )),
                        ],
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          radius: 2.6.h,
                          backgroundImage: NetworkImage(
                            event.senderModel![1],
                          ),
                        ),
                        title: Text(
                          event.senderModel![2],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 2.5.h),
                        ),
                        subtitle: Text(eventCreatedTime),
                        trailing: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                event.privacy.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 2.h),
                              ),
                              Icon(
                                Icons.arrow_drop_down_outlined,
                                color: Colors.black,
                              )
                            ],
                          )),
                          height: 5.h,
                          width: 12.h,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 3),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: Text(
                              eventStartTime,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 2.h),
                            )),
                            height: 5.h,
                            width: 8.h,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            event.eventName.toString(),
                            style: TextStyle(
                                fontSize: 4.h, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            eventStartDate,
                            style: TextStyle(
                                fontSize: 2.h,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.blue,
                          ),
                          Text(
                            "Location:  " + event.location.toString(),
                            style: TextStyle(
                                fontSize: 2.h, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Material(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(10),
                        elevation: 10,
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: event.eventImage.toString(),
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              fit: BoxFit.cover,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          height: 25.h,
                          width: double.infinity,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Videos Related to Event",
                        style: TextStyle(
                            fontSize: 2.5.h, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        height: 16.h,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: event.eventVideos!.length + 2,
                          itemBuilder: (BuildContext context, int index) {
                            int length = event.eventVideos!.length + 2;

                            if (index != length - 1 && index != length - 2) {
                              final videoPlayerController =
                                  VideoPlayerController.networkUrl(Uri.parse(
                                      event.eventVideos![index].toString()));

                              // Initialize the video player controller and wait for it to complete
                              videoPlayerController.initialize();

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width:
                                      0.35 * MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: AspectRatio(
                                      aspectRatio: videoPlayerController
                                          .value.aspectRatio,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          VideoPlayer(videoPlayerController),
                                          IconButton(
                                            icon: Icon(Icons.play_arrow),
                                            color: Colors.white,
                                            onPressed: () {
                                              videoPlayerController.play();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (index == length - 2) {
                              if (_video != null) {
                                _videoPlayerController =
                                    VideoPlayerController.file(_video!)
                                      ..initialize().then((_) {
                                        //_videoPlayerController!.play();
                                      });
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 0.35 *
                                        MediaQuery.of(context).size.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: AspectRatio(
                                        aspectRatio: _videoPlayerController!
                                            .value.aspectRatio,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VideoPlayer(_videoPlayerController!),
                                            IconButton(
                                                icon: Icon(Icons.upload),
                                                color: Colors.white,
                                                onPressed: () {
                                                  _uploadVideo(widget.eventId);
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }
                            if (index == length - 1) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 5),
                                child: GestureDetector(
                                  onTap: _selectVideo,
                                  child: DottedBorder(
                                    strokeWidth: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                      ),
                                      width: 0.25 *
                                          MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image(
                                            height: 0.04 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .height,
                                            image:
                                                AssetImage("images/upload.png"),
                                          ),
                                          SizedBox(
                                            height: 0.02 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .height,
                                          ),
                                          Text(
                                            "Select Video",
                                            style: TextStyle(
                                                fontSize: 0.015 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            color: Colors.orange[200],
                            height: 5.h,
                            minWidth: 11.w,
                            onPressed: () {
                              ju.showUsers(context, event.joined,
                                  event.sender![0], widget.userModel);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.remove_red_eye),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Text(
                                  (event.joined?.length.toString() ?? '') +
                                      " People Joined",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                event.price.toString(),
                                style: TextStyle(
                                    fontSize: 2.5.h,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Text(
                                remainings + " spots left",
                                style: TextStyle(
                                    fontSize: 2.2.h,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        event.description.toString(),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              height: 7.h,
                              color: widget.userModel.uid != event.sender![0]
                                  ? Colors.orange[400]
                                  : Colors.grey,
                              onPressed: () {
                                joinEvent(widget.userModel.uid.toString(),
                                    widget.eventId, context);
                              },
                              child: Text(
                                  widget.userModel.uid != event.sender![0]
                                      ? "Join Event"
                                      : "You're Creater of this event"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: widget.userModel.uid == event.sender![0]
                                  ? MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      height: 7.h,
                                      color: Colors.red[300],
                                      onPressed: () async {
                                        deleteEvent(
                                            context,
                                            widget.eventId.toString(),
                                            widget.userModel,
                                            widget.firebaseuser,
                                            event.eventId.toString());
                                      },
                                      child: Text("Delete Event"),
                                    )
                                  : Text(
                                      "It's not Over....Until I Win!",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 4.w,
                                      ),
                                    )),
                          SizedBox(
                            width: 3.w,
                          ),
                          Expanded(
                              child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            height: 7.h,
                            color: Colors.blue[400],
                            onPressed: () {},
                            child: Text("Invite Friends"),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
