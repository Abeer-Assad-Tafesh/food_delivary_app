import 'dart:convert';
import 'package:food_delivary_app/data/api/api_client.dart';
import 'package:food_delivary_app/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart_model.dart';

class CartRepo extends GetxService {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> storedCart = [];
  List<String> storedHistoryCart = [];
  var checkOutTime;

  // below code is to store and get cart data when app closed and then opened again
  void addToCartList(List<CartModel> cartList) {
     /*sharedPreferences.remove(AppConstants.CART_LIST);
     sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
     return ;*/

    var time = DateTime.now().toString();
    storedCart = [];
    cartList.forEach((element) {
      element.time = time;
      // we need to convert the CartModel/object into (String) because sh.p. accepts only String type
      return storedCart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.CART_LIST, storedCart);
    print(sharedPreferences.getStringList(AppConstants.CART_LIST));
  }

  List<CartModel> getCartList() {
    List<String> cart = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      cart = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
    List<CartModel> cartList = [];
    cart.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  // below code is to store checked out cart products in cart history
  void addToCartHistoryList() {
    // checkOutTime = DateTime.now().toString();

    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      storedHistoryCart =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < storedCart.length; i++) {
      storedHistoryCart.add(storedCart[i]);
    }
    removeCart(); // to clear cart items from sh.p.
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, storedHistoryCart);
    // print(sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST));
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      storedHistoryCart =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartHistoryList = [];
    CartModel objectElement;
    storedHistoryCart.forEach((element) {
      objectElement = CartModel.fromJson(jsonDecode(element));
      // objectElement.time = checkOutTime;
      cartHistoryList.add(objectElement);
    });
    return cartHistoryList;
  }

  // remove items exits in cart page
  void removeCart() {
    // remove from memory
    storedCart = [];
    // remove from local storage
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void removeHistoryCart(){
    removeCart();
    storedHistoryCart = [];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }


}
