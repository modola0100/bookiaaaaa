import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/wishlist/data/models/wish_list_response/datum.dart';
import 'package:bookia/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitialState());

  List<WishListProduct> books = [];

  getWishlist() async {
    emit(WishlistLoadingState());
    var res = await WishlistRepo.getWishlist();
    if (res != null) {
      books = res.data?.data ?? [];
      emit(WishlistSuccessState());
    } else {
      emit(WishlistErrorState());
    }
  }

  removeFromWishList({required int productId}) async {
    emit(WishlistLoadingState());
    var res = await WishlistRepo.removeWishlist(productId: productId);
    if (res != null) {
      books = res.data?.data ?? [];
      emit(WishlistSuccessState());
    } else {
      emit(WishlistErrorState());
    }
  }

  addToCart({required int productId}) async {
    var res = await CartRepo.addToCart(productId: productId);
    if (res != null) {
      emit(WishlistSuccessState(message: 'Added to Cart'));
    } else {
      emit(WishlistErrorState());
    }
  }
}
