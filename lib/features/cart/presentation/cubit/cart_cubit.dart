import 'package:bookia/core/services/local/shered_preferences.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_response.dart';
import 'package:bookia/features/cart/data/models/place_order.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  CartResponse? cartResponse;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var govController = TextEditingController();

  int selcetGovId = -1;

  getCart() async {
    emit(CartLoadingState());
    var res = await CartRepo.getCart();
    if (res != null) {
      cartResponse = res;
      emit(CartSuccessState());
    } else {
      emit(CartErrorState());
    }
  }

  removeCart({required int cartItemId}) async {
    final items = cartResponse?.data?.cartItems;
    if (items == null) return;

    items.removeWhere((item) => item.itemId == cartItemId);
    emit(CartSuccessState());
    try {
      var res = await CartRepo.removeFromCart(cartItemId: cartItemId);
      if (res != null) {
        cartResponse = res;
        emit(CartSuccessState());
      }
    } on Exception {
      emit(CartErrorState());
    }
  }

  updateCart({required int cartItemId, required int quantity}) async {
    var res = await CartRepo.updateCart(
      cartItemId: cartItemId,
      quantity: quantity,
    );
    if (res != null) {
      cartResponse = res;
      emit(CartSuccessState());
    } else {
      emit(CartErrorState());
    }
  }

  placeOrder() async {
    emit(CartLoadingState());
    var params = PlaceOrderparams(
      governorateId: selcetGovId,
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      address: addressController.text,
    );

    var res = await CartRepo.placeOrder8Cart(params);
    if (res) {
      SheredPreferences.setData('user_name', nameController.text);
      SheredPreferences.setData('user_email', emailController.text);
      SheredPreferences.setData('user_phone', phoneController.text);
      SheredPreferences.setData('user_address', addressController.text);
      SheredPreferences.setData('user_governorate_id', selcetGovId);
      emit(CartSuccessState());
    } else {
      emit(CartErrorState());
    }
  }

  refillData() {
    nameController.text = SheredPreferences.getdata('user_name') ?? '';
    emailController.text = SheredPreferences.getdata('user_email') ?? '';
    phoneController.text = SheredPreferences.getdata('user_phone') ?? '';
    addressController.text = SheredPreferences.getdata('user_address') ?? '';
    final govValue = SheredPreferences.getdata('user_governorate_id');
    if (govValue is int) {
      selcetGovId = govValue;
    } else if (govValue is String) {
      selcetGovId = int.tryParse(govValue) ?? -1;
    } else {
      selcetGovId = -1;
    }
  }
}
