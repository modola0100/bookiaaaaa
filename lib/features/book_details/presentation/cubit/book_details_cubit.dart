import 'package:bookia/features/book_details/data/models/product.dart';
import 'package:bookia/features/book_details/data/repo/book_details_repo.dart';
import 'package:bookia/features/book_details/presentation/cubit/book_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  BookDetailsCubit() : super(BookDetailsIntialState());

  List<BookProduct> books = [];
  List<BookProduct> products = [];
  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  getBookDetails() async {
    emit(BookDetailsLoadingState());
    var res = await BookDetailsRepo.getBookDetails();

    if (res != null) {
      books = res.data?.products ?? [];
      emit(BookDetailsISuccessState());
    } else {
      emit(BookDetailsErrorState());
    }
  }

  getSearchBook(String name) async {
    if (name.isEmpty) {
      products = [];
      isSearching = false;
      emit(BookDetailsISuccessState());
      return;
    }
    isSearching = true;
    emit(BookDetailsLoadingState());
    var res = await BookDetailsRepo.getSearchBook(name);
    if (res != null) {
      products = res.data?.products ?? [];

      emit(BookDetailsISuccessState());
    } else {
      emit(BookDetailsErrorState());
    }
  }

  List<BookProduct> displayProduct() {
    if (products.isNotEmpty) {
      return products;
    }
    return books;
  }

  bool searchResault() {
    return isSearching && products.isEmpty;
  }
}
