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
          color: Colors.indigo.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(12)),

        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.person),
            const SizedBox(width: 20,),
            Text(text),
          ],
        ),
      ),
    );
  }
}