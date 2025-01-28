import 'dart:developer';
import 'package:aifer_task/controller/product_provider.dart';
import 'package:aifer_task/utils/common/color.dart';
import 'package:aifer_task/widgets/loading_indicator.dart';
import 'package:aifer_task/widgets/product_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //scroll controller to listen when scrolling comes to the end of the lsit
    scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
    });
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
              Consumer<ProductProvider>(
                builder: (context, val, child) {
                  if (val.isLoading && val.photos.isEmpty) {
                    log('val.isloadig or photos.isempty case');
                    return const ShimmerEffect();
                  }
                  return MasonryGridView.builder(
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: val.photos.length + (val.isLoading ? 1 : 0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == val.photos.length) {
                        log('index == val.photos.length');
                        return const SingleShimmerEfect();
                      }
                      final data = val.photos[index];
                      return index == 9
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: ProductContainer(
                                image: val.photos.first.urls!.raw.toString(),
                                name:
                                    '10th item again showing the first item in the list',
                                onPressed: () {},
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: ProductContainer(
                                image: data.urls!.raw.toString(),
                                name: data.altDescription.toString(),
                                onPressed: () async {
                                  try {
                                    await val.downloadImage(
                                        data.urls!.raw.toString(),
                                        data.altDescription.toString(),
                                        context);
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

  void _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // when scrolling comes to maxend function gets called again, showing another set of products
      await context.read<ProductProvider>().fetchProducts();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
