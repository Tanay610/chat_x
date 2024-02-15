import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTiletap;
  const UserTile({super.key, required this.text, required this.onTiletap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTiletap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.purple.shade200, Colors.purple.shade600,
          ]),
          borderRadius: const BorderRadius.all(Radius.circular(12)),

        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(25),
        child: Row(
          children: [
            Icon(Icons.person,
            
            ),
            const SizedBox(width: 20,),
            Text(text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            ),
          ],
        ),
      ),
    );
  }
}