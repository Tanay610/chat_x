
import 'package:chat_x/services/chat_services/chat_service.dart';
import 'package:chat_x/view/components/bubble_x.dart';
import 'package:chat_x/view/components/textFiled_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/auth_services/auth_methods.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;
  const ChatPage({
    Key? key,
    required this.receiverEmail,
    required this.receiverId,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _inputChatContoller = TextEditingController();

  //* chat and auth services
  final ChatServices _chatServices = ChatServices();

  final AuthServices _authServices = AuthServices();

  //* for textfield focus
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      //* cause a delay so that the keyboard has time to show up
      //* then the amount of remaining space will be calculated.
      //* then scroll down
      Future.delayed(const Duration(), ()=>scrollDown());

     });

     // wait a bit for listview to be built, then scroll to bottom
     Future.delayed(const Duration(milliseconds: 500),()=>scrollDown());
  }

  @override
  void dispose() {
    super.dispose();
    _inputChatContoller.dispose();
    _focusNode.dispose();
  }

  //* scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown(){
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.decelerate);
  }

  //* send messages
  void sendMessages()async{
    // if there is something inside the textfield only then send message
    if (_inputChatContoller.text.isNotEmpty) {
      //* send the message
      await _chatServices.sendMessage(widget.receiverId, _inputChatContoller.text);

      //* clear text controller
      _inputChatContoller.clear();
    }
    
      scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade200,
        title: Text(widget.receiverEmail,
        style: TextStyle(
          color: Colors.white
        ),
        
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
       
        
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessagesList()),

          //user input
          _buildUserInput(context),
        ],
      )
    );
  }

  Widget _buildMessagesList(){
    String senderId = _authServices.getCurrentUser()!.uid;
    return StreamBuilder(stream: _chatServices.getMessages(widget.receiverId, senderId), builder: (context, snapshot){
      //* errors
      if (snapshot.hasError) {
        return const Text("Error");
      }

      //* loading
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text("Loading...");
      }

      //* return list view
      return ListView(
        controller: _scrollController,
        children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
      ); 
    });
  }

  //* build message item
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
        //? is current \user
        bool isCurrentUser = data['senderId'] == _authServices.getCurrentUser()!.uid;

        //? align message to the right is sender is the current user, otherwsise left
        var alignment = isCurrentUser ? Alignment.centerRight:Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          ChatBubble(message:data["message"], isCurrentUser: isCurrentUser),
        ],
      ));
  }

  //* build user input
  Widget _buildUserInput(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          //* textfield should take most of the space
          Expanded(child: TextFieldWidget(
            focusNode: _focusNode,
            hintName: "Type a message..", obsecure: false, fieldController: _inputChatContoller)),
      
          
          //* send button
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.purple.shade400,
            ),
            margin: const EdgeInsets.only(right: 15),
            child: IconButton(onPressed: sendMessages, icon: const Icon(Icons.send,
            color: Colors.white,
            )))
        ],
      ),
    );
  }
}
