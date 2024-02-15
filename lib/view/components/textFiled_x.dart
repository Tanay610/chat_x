
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintName;
  final bool obsecure;
  final TextEditingController fieldController;
  final FocusNode? focusNode;
  const TextFieldWidget({super.key, required this.hintName, required this.obsecure, required this.fieldController, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: TextField(
        focusNode: focusNode,
        obscureText: obsecure,
        controller: fieldController,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
      
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintName,
          hintStyle: TextStyle(
            color: Colors.purple.shade200
          )
        ),
      
      ),
    );
  }
}