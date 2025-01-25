import 'dart:developer';

import 'package:aifer_task/model/product_model.dart';
import 'package:dio/dio.dart';

class ProductService {
  Dio dio = Dio();
  final String _accessKey = 'Mwc4RV5IQFjgu5e-227WjOWKyV1QLrveixYk_B0BNCM';
  final String _baseUrl = "https://api.unsplash.com";

  Future<List<ProductModel>?> getAllPhotos({required int offset}) async {
    try {
      Response response = await dio.get(
        '$_baseUrl/photos',
        queryParameters: {
          "client_id": _accessKey,
          'page': offset, // Adjust pagination parameter
          'per_page': 15, // Limit items per page
        },
        options: Options(validateStatus: (status) => status! < 599),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        final res = data.map((e) => ProductModel.fromJson(e)).toList();
        log(res.toString());
        return res;
      }
    } catch (e) {
      log("Error fetching photos: $e");
      return [];
    }
    return null;
  }
}
