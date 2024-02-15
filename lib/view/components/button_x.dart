import 'package:flutter/material.dart';

class ButtonX extends StatelessWidget {
  final String buttonName;
  final void Function()? onButtonTap;
  const ButtonX({super.key, required this.buttonName,  required this.onButtonTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: ClipRRect(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
          ),
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Text(buttonName,
            style: TextStyle(
              color: Colors.purple.shade500,
              fontWeight: FontWeight.w500
            ),
            ),
          ),
        ),
      ),
    );
  }
}