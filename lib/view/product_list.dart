import 'dart:developer';

import 'package:aifer_task/controller/product_controller.dart';
import 'package:aifer_task/utils/common/color.dart';
import 'package:aifer_task/widgets/alert_box.dart';
import 'package:aifer_task/widgets/loading_indicator.dart';
import 'package:aifer_task/widgets/product_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ScrollController scrollController = ScrollController();

  final c = Get.put(ProductController());
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.fetchProducts();
    });
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !c.isLoading.value) {
      c.fetchProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Container(
        color: kwhite,
        padding: const EdgeInsets.only(left: 4, right: 4),
        width: double.infinity,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "All Products",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kblack,
                  ),
                ),
              ),
              GetBuilder<ProductController>(
                id: 'update-product',
                builder: (c) {
                  if (c.isLoading.value && c.photos.isEmpty) {
                    return const ShimmerEffect();
                  }
                  return MasonryGridView.builder(
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: c.photos.length + (c.isLoading.value ? 1 : 0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == c.photos.length) {
                        // Show a loading indicator at the bottom
                        return const SingleShimmerEfect();
                      }
                      final data = c.photos[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: ProductContainer(
                          image: data.urls!.raw.toString(),
                          name: data.altDescription.toString(),
                          onPressed: () async {
                            try {
                              await c.downloadImage(
                                data.urls!.raw.toString(),
                                data.altDescription.toString(),
                              );
                            } catch (e) {
                              log(e.toString(), name: 'downlad error');
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
