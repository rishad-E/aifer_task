import 'dart:developer';

import 'package:aifer_task/controller/product_controller.dart';
import 'package:aifer_task/utils/common/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DownloadBox extends StatelessWidget {
  final String imageUrl;
  final String name;
  DownloadBox({super.key, required this.imageUrl, required this.name});
  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kblack.withOpacity(0.7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 30,
      title: const Center(child: Text("Delete Task")),
      content: Text(
        'Download this Image to Gallery',
        style: TextStyle(color: kwhite),
      ),
      actions: [
        TextButton(
          child: const Text(
            'No',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text(
            'Yes',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () async {
            try {
              await controller.downloadImage(imageUrl, name);
            } catch (e) {
              log(e.toString(), name: 'downlad error');
            }
            Get.back();
          },
        )
      ],
    );
  }
}
