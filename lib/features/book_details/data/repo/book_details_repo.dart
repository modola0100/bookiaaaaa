import 'dart:developer';

import 'package:bookia/core/services/dio/dio_endpoint.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/features/book_details/data/models/book_details_response/book_details_response.dart';
import 'package:bookia/features/book_details/data/models/search_book_response/search_book_response.dart';

class BookDetailsRepo {
  static Future<BookDetailsResponse?> getBookDetails() async {
    try {
      var res = await DioProvider.get(path: Endpoint.getBookDetails);
      if (res.statusCode == 200) {
        return BookDetailsResponse.fromJson(res.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<SearchBookResponse?> getSearchBook(String name) async {
    try {
      var res = await DioProvider.get(
        path: Endpoint.getSearchBook,
        queryParameters: {'name': name},
      );
      if (res.statusCode == 200) {
        return SearchBookResponse.fromJson(res.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
