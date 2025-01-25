import 'dart:developer';
import 'dart:io';

import 'package:aifer_task/model/product_model.dart';
import 'package:aifer_task/service/product_service.dart';
import 'package:aifer_task/utils/common/color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ProductController extends GetxController {
  final ProductService _service = ProductService();

  final RxList<ProductModel> _photos = <ProductModel>[].obs;
  final RxBool _isLoading = false.obs;
  int _offset = 1;

  RxList<ProductModel> get photos => _photos;
  RxBool get isLoading => _isLoading;
  // int _currentPage = 1;
  // int get currentPage => _currentPage;
  int get offset => _offset;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    // scrollController.addListener(_onScroll);
  }

  void refreshPage() {
    _offset = 0;
    _photos.clear();
    update(['update-product']);
  }

  Future<void> fetchProducts() async {
    log('called', name: 'fetchprouduct');
    if (_isLoading.value) return;
    _isLoading.value = true;
    update(['update-product']);
    try {
      final data = await _service.getAllPhotos(offset: _offset);
      if (data != null && data.isNotEmpty) {
        _photos.addAll(data);
        _offset++; // Incrementing offset for the next page
      }
    } catch (e) {
      log(e.toString(), name: 'error controller');
    } finally {
      _isLoading.value = false;
      update(['update-product']);
    }
  }

  Future<void> downloadImage(String imageUrl, String name) async {
    await permissionRequest();
    var status = await Permission.storage.request();
    log('storage=>${status.isGranted.toString()}');
    if (!status.isGranted) {
      Get.snackbar(
        "Permission Denied",
        "Storage permission is required to download images.",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        backgroundColor: kred.withOpacity(0.7),
        colorText: kwhite,
      );
      return;
    } else {
      Directory directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        log('directory not exists=>$directory');
        Get.snackbar(
          "Error",
          "Failed to download Image",
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
          backgroundColor: kred.withOpacity(0.7),
          colorText: kwhite,
        );
      } else {
        log('directory exists=>$directory and ImageUrl=>$imageUrl');
        String savePath = '${directory.path}/$name.jpg';
        await Dio().download(imageUrl, savePath);
        await GallerySaver.saveImage(savePath, albumName: "Unsplash Images");
        Get.snackbar(
          "Downloaded",
          "Image downloaded to gallery",
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: kwhite,
        );
      }
    }
  }

  Future<void> permissionRequest() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.isGranted) {
        return;
      } else {
        var status = await Permission.storage.request();
        if (status.isGranted) {
          return;
        } else if (status.isDenied) {
          status = await Permission.storage.request();
          if (status.isGranted) {
            return;
          } else if (status.isPermanentlyDenied) {
            await openAppSettings();
            if (await Permission.storage.isGranted) {
              return;
            } else {
              Get.snackbar(
                "Permission Permanently Denied",
                "Storage permission is required to download images.",
                snackPosition: SnackPosition.TOP,
                duration: const Duration(seconds: 2),
                backgroundColor: kred.withOpacity(0.7),
                colorText: kwhite,
              );
            }
          }
        }
      }
    }
  }
}
