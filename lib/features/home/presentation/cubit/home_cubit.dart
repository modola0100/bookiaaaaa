import 'package:bookia/core/services/local/shered_preferences.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/home/data/models/best_seller_response/best_seller_response.dart';
import 'package:bookia/features/home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/home/data/models/slider_response/slider.dart';
import 'package:bookia/features/home/data/models/slider_response/slider_response.dart';
import 'package:bookia/features/home/data/repo/home_repo.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<Product> products = [];
  List<SliderModel>? sliders = [];

  getData() async {
    emit(HomeLoadingState());
    var result = await Future.wait([
      HomeRepo.getBestSeller(),
      HomeRepo.getSlider(),
    ]);

    var bestSellerRes = result[0] as BestSellerResponse?;
    var sliderRes = result[1] as SliderResponse?;

    if (bestSellerRes != null || sliderRes != null) {
      products = bestSellerRes?.data?.products ?? [];
      sliders = sliderRes?.data?.sliders ?? [];
      emit(HomeSuccessState());
    } else {
      emit(HomeErrorState('Somthig Wrong'));
    }
  }

  addAndRemoveTowishList({required int productId}) async {
    emit(HomeLoadingState());
    if (cachedIfWishlist(productId)) {
      var res = await WishlistRepo.removeWishlist(productId: productId);
      if (res != null) {
        emit(HomeSuccessState(message: 'Removed from Wishlist'));
      } else {
        emit(HomeErrorState('Not Removed to Wishlist'));
      }
    } else {
      var res = await WishlistRepo.addWishlist(productId: productId);
      if (res != null) {
        emit(HomeSuccessState(message: 'Added to Wishlist'));
      } else {
        emit(HomeErrorState('Added to Wishlist'));
      }
    }
  }

  addToCart({required int productId}) async {
    emit(HomeLoadingState());
    var res = await CartRepo.addToCart(productId: productId);
    if (res != null) {
      emit(HomeSuccessState(message: 'Added to Cart'));
    } else {
      emit(HomeErrorState('Not Added to Cart'));
    }
  }

  bool cachedIfWishlist(int productId) {
    var cached = SheredPreferences.getWishlist();
    return cached?.contains(productId) ?? false;
  }
}
