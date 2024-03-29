
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageX {
  final String senderId;
  final String senderEmail;
  final String recieverId;
  final String message;
  final Timestamp timestamp;

  MessageX({required this.senderId, required this.senderEmail, required this.recieverId, required this.message, required this.timestamp});
  
  
  Map<String, dynamic> toMap(){
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': recieverId,
      'message': message,
      'timestamp': timestamp
    };
  }
}