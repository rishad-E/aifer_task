import 'package:flutter/material.dart';

Widget choiceBox({double? height, double? width}) {
  return SizedBox(
    height: height,
    width: width,
  );
}

Widget categoryContainer(String cat, Color textC, Color bg) {
  return Container(
    decoration:
        BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
    child: Text(
      cat,
      style:
          TextStyle(color: textC, fontWeight: FontWeight.w500, fontSize: 14),
    ),
  );
}
