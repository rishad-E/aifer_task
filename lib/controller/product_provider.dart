import 'dart:developer';
import 'dart:io';

import 'package:aifer_task/model/product_model.dart';
import 'package:aifer_task/service/product_service.dart';
import 'package:aifer_task/utils/snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class ProductProvider extends ChangeNotifier {
  final ProductService _service = ProductService();

  final List<ProductModel> _photos = [];
  bool _isLoading = false;
  int _offset = 1;

  List<ProductModel> get photos => _photos;
  bool get isLoading => _isLoading;
  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    try {
      final data = await _service.getAllPhotos(offset: _offset);
      if (data != null && data.isNotEmpty) {
        _photos.addAll(data.reversed.toList());
        _offset++;
      }
    } catch (e) {
      log(e.toString(), name: 'error controller');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> downloadImage(String imageUrl, String name, context) async {
    Directory directory = Directory('/storage/emulated/0/Download');
    if (!await directory.exists()) {
      log('directory not exists=>$directory');
      showCustomSnackbar(
          title: 'Error',
          message: 'Failed to download Image',
          context: context);
    } else {
      log('directory exists=>$directory and ImageUrl=>$imageUrl');
      String savePath = '${directory.path}/$name.jpg';
      await Dio().download(imageUrl, savePath);
      showCustomSnackbar(
          title: "Downloaded",
          message: "Image downloaded to gallery",
          context: context);
    }
  }
}
