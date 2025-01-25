import 'package:aifer_task/utils/common/color.dart';
import 'package:aifer_task/widgets/widgets.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appBarHome() {
  return AppBar(
    backgroundColor: kblack,
    elevation: 0,
    toolbarHeight: 70,
    actions: [
      Container(
        decoration: BoxDecoration(color: kwhite, shape: BoxShape.circle),
        padding: const EdgeInsets.all(1),
        height: 30,
        width: 30,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            'asset/images/profile.jpeg',
            fit: BoxFit.cover,
            // color: Colors.grey.withOpacity(0.3),
          ),
        ),
      ),
      choiceBox(width: 15),
      Container(
        decoration:
            BoxDecoration(color: kred, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        child: Text(
          'Follow',
          style: TextStyle(
              color: kwhite, fontWeight: FontWeight.w600, fontSize: 12),
        ),
      ),
      choiceBox(width: 15)
    ],
  );
}
