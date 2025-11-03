class WishlistState {}

class WishlistInitialState extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistSuccessState extends WishlistState {
  String? message;
  WishlistSuccessState({this.message});
}

class WishlistErrorState extends WishlistState {}
