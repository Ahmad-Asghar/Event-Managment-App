
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/UserModel.dart';
import '../Models/chatRoomModel.dart';

Future<ChatRoomModel?> getChatRoomModel(UserModel targetUser,String currentUserId) async {
  ChatRoomModel? chatroom;
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection("ChatRooms")
      .where("participants.$currentUserId", isEqualTo: true)
      .where("participants.${targetUser.uid}", isEqualTo: true)
      .get();

  if (snapshot.docs.isNotEmpty) {
    print("Already Have a Chat Room");

    var docData = snapshot.docs[0].data();
    ChatRoomModel existingChatRoom =
    ChatRoomModel.fromMap(docData as Map<String, dynamic>);
    chatroom = existingChatRoom;
  } else {
    print("Create a Chat Room");
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    ChatRoomModel newChatRoom = ChatRoomModel(
      chatRoomId: id,
      lastmessege: "",
      participants: {
        currentUserId: true,
        targetUser.uid.toString(): true,
      },
      users: [currentUserId, targetUser.uid.toString()],
      datetime: DateTime.now(),
    );
    await FirebaseFirestore.instance
        .collection("ChatRooms")
        .doc(newChatRoom.chatRoomId)
        .set(newChatRoom.toMap());
    chatroom = newChatRoom;
    print("Chat Room Created!");
  }
  return chatroom;
}