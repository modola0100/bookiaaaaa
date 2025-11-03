import 'dart:developer';

import 'package:bookia/core/services/dio/dio_endpoint.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/features/home/data/models/best_seller_response/best_seller_response.dart';
import 'package:bookia/features/home/data/models/slider_response/slider_response.dart';

class HomeRepo {
  static Future<BestSellerResponse?> getBestSeller() async {
    try {
      var res = await DioProvider.get(path: Endpoint.productBestSeller);

      if (res.statusCode == 200) {
        return BestSellerResponse.fromJson(res.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<SliderResponse?> getSlider() async {
    try {
      var res = await DioProvider.get(path: Endpoint.slider);
      if (res.statusCode == 200) {
        return SliderResponse.fromJson(res.data);
      }
      return null;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
