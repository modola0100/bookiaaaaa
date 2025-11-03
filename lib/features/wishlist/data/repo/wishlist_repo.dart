import 'dart:developer';

import 'package:bookia/core/services/dio/dio_endpoint.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shered_preferences.dart';
import 'package:bookia/features/wishlist/data/models/wish_list_response/datum.dart';
import 'package:bookia/features/wishlist/data/models/wish_list_response/wish_list_response.dart';

class WishlistRepo {
  static Future<WishListResponse?> getWishlist() async {
    try {
      var res = await DioProvider.get(
        path: Endpoint.getWishlist,
        headers: {
          'Authorization': 'Bearer ${SheredPreferences.getUserData()?.token}',
        },
      );

      if (res.statusCode == 200) {
        var data = WishListResponse.fromJson(res.data);
        saveWishlist(data.data?.data ?? []);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<WishListResponse?> removeWishlist({
    required int productId,
  }) async {
    try {
      var res = await DioProvider.post(
        path: Endpoint.removeWishlist,
        data: {"product_id": productId},
        headers: {
          'Authorization': 'Bearer ${SheredPreferences.getUserData()?.token}',
        },
      );

      if (res.statusCode == 200) {
        var data = WishListResponse.fromJson(res.data);
        saveWishlist(data.data?.data ?? []);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<WishListResponse?> addWishlist({required int productId}) async {
    try {
      var res = await DioProvider.post(
        path: Endpoint.addWishlist,
        data: {"product_id": productId},
        headers: {
          'Authorization': 'Bearer ${SheredPreferences.getUserData()?.token}',
        },
      );

      if (res.statusCode == 200) {
        var data = WishListResponse.fromJson(res.data);
        saveWishlist(data.data?.data ?? []);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static saveWishlist(List<WishListProduct> wishlistIds) {
    if (wishlistIds.isEmpty) {
      SheredPreferences.saveWishList([]);
      return;
    }
    List<int> bookIds = [];
    for (var id in wishlistIds) {
      bookIds.add(id.id ?? 0);
    }
    SheredPreferences.saveWishList(bookIds);
  }
}
