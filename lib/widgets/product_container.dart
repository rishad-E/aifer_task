import 'dart:math';

import 'package:aifer_task/controller/product_controller.dart';
import 'package:aifer_task/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductContainer extends StatelessWidget {
  final String image;
  final String name;
  final void Function()? onPressed;
  ProductContainer(
      {super.key,
      required this.image,
      required this.name,
      required this.onPressed});
  final controller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.white,
                        height: 180,
                        width: 50,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Row(
                  children: [
                    Flexible(
                        child: Text(
                      name,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 2,
                    )),
                    choiceBox(width: 5),
                    IconButton(
                      style: const ButtonStyle(
                          visualDensity: VisualDensity.compact),
                      icon: const Icon(Icons.download),
                      onPressed: onPressed,
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: Text(
                getPrice(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getPrice() {
    var random = Random();
    int val = 49 + random.nextInt(99);
    return '\$$val';
  }
}
