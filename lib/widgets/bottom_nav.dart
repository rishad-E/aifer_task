import 'package:aifer_task/utils/common/color.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration:
          BoxDecoration(color: kwhite, borderRadius: BorderRadius.circular(24)),
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(
                'asset/images/pinterest.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Icon(Icons.search, color: Colors.grey.shade400, size: 30),
         Icon(Icons.notifications, color: Colors.grey.shade400, size: 30),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(
                'asset/images/OIP.jpeg',
                fit: BoxFit.cover,
                // color: Colors.grey.withOpacity(0.3),
              ),
            ),
          )
        ],
      ),
    );
  }
}
