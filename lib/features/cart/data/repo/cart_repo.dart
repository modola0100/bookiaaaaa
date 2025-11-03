import 'dart:developer';

import 'package:bookia/core/services/dio/dio_endpoint.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shered_preferences.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_response.dart';
import 'package:bookia/features/cart/data/models/place_order.dart';

class CartRepo {
  static Future<CartResponse?> getCart() async {
    try {
      var res = await DioProvider.get(path: Endpoint.getcart, headers: {"Authorization": "Bearer ${SheredPreferences.getUserData()?.token}"});
      if (res.statusCode == 200) {
        return CartResponse.fromJson(res.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> addToCart({required int productId}) async {
    try {
      var res = await DioProvider.post(path: Endpoint.addToCart, data: {"product_id": productId}, headers: {"Authorization": "Bearer ${SheredPreferences.getUserData()?.token}"});
      if (res.statusCode == 201) {
        return CartResponse.fromJson(res.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> updateCart({required int cartItemId, required int quantity}) async {
    try {
      var res = await DioProvider.post(path: Endpoint.updateToCart, data: {"cart_item_id": cartItemId, "quantity": quantity}, headers: {"Authorization": "Bearer ${SheredPreferences.getUserData()?.token}"});
      if (res.statusCode == 201) {
        return CartResponse.fromJson(res.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> removeFromCart({required int cartItemId}) async {
    try {
      var res = await DioProvider.post(path: Endpoint.removeFromCart, data: {"cart_item_id": cartItemId}, headers: {"Authorization": "Bearer ${SheredPreferences.getUserData()?.token}"});
      if (res.statusCode == 201) {
        return CartResponse.fromJson(res.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> placeOrder8Cart(PlaceOrderparams params) async {
    try {
      var res = await DioProvider.post(path: Endpoint.placeOrderCart, data: params.toJson(), headers: {"Authorization": "Bearer ${SheredPreferences.getUserData()?.token}"});
      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }
}
