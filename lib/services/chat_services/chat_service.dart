
import 'package:chat_x/models/msg_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //* get user stream

  Stream<List<Map<String, dynamic>>> getUserSTream() {
    return _firestore.collection("Users123").snapshots().map((event) {
      return event.docs.map((doc) {
        //* get through each individual user
        final user = doc.data();

        //* return user
        return user;
      }).toList();
    });
  }

  //* send message

  Future<void> sendMessage(String recieverId, message) async{
    // get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //? create a new message
    MessageX neWMessage = MessageX(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        recieverId: recieverId,
        message: message,
        timestamp: timestamp);

   //? construct chat rooms ID for the two users (sorted to ensure uniqueness)
   List<String> ids = [currentUserId, recieverId];
   ids.sort(); //? sort the ids (this ensure the chatRoomID is the same for any 2 people)  
   String chatRoomID = ids.join('_');

   //? add the new id to the firestore
   await _firestore.collection("chat_rooms").doc(chatRoomID).collection("messages").add(neWMessage.toMap());
  }


  //! delete messages 
    Future<void> _deleteMessage(String messageId) async {
    try {
      await _firestore.collection('messages').doc(messageId).delete();
    } catch (e) {
      Text(e.toString());
    }
  }



  //* get messages
  Stream<QuerySnapshot> getMessages(String userId, otheruserId){
    // construct a chatroom ID for the two users
    List<String> ids = [userId, otheruserId];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore.collection("chat_rooms").doc(chatRoomID).collection('messages').orderBy("timestamp", descending: false).snapshots();
  }
}
