import 'package:flutter/material.dart';
import 'package:food_delivary_app/base/no_data__page.dart';
import 'package:food_delivary_app/controller/cart_controller.dart';
import 'package:food_delivary_app/controller/popular_product_controller.dart';
import 'package:food_delivary_app/screens/auth/sign_in_page.dart';
import 'package:food_delivary_app/screens/cart/cart_history.dart';
import 'package:food_delivary_app/screens/food/popular_product_detail.dart';
import 'package:food_delivary_app/screens/food/recommended_product_detail.dart';
import 'package:food_delivary_app/screens/home/main_food_page.dart';
import 'package:food_delivary_app/utils/app_constant.dart';
import 'package:food_delivary_app/utils/dimensions.dart';
import 'package:food_delivary_app/widgets/app_icon.dart';
import 'package:food_delivary_app/widgets/big_text.dart';
import 'package:food_delivary_app/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../controller/recommended_product_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // app bar
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Get.off(()=>MainFoodPage());
                  },
                  child: const AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: Colors.green,
                    size: 40,
                  ),
                ),
                 SizedBox(width: Dimensions.width10*14),
                GestureDetector(
                  onTap: () {
                    Get.to(() => MainFoodPage());
                  },
                  child: const AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: Colors.green,
                    size: 40,
                  ),
                ),
                const AppIcon(
                  icon: Icons.shopping_cart_checkout,
                  iconColor: Colors.white,
                  backgroundColor: Colors.green,
                  size: 40,
                ),
              ],
            ),
          ),
          // body
          GetBuilder<CartController>(builder: (controller) {
            var _cartItems = controller.getItems.length;
            return _cartItems > 0
                ? Positioned(
                    top: Dimensions.height10 * 10,
                    left: Dimensions.width10 * 2,
                    right: Dimensions.width10 * 2,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Dimensions.height10 * 2),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child:
                            GetBuilder<CartController>(builder: (controller) {
                          var _cartList = controller.getItems;
                          return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (context, index) => Container(
                              height: Dimensions.height10 * 10,
                              width: double.maxFinite,
                              margin:
                                  EdgeInsets.only(top: Dimensions.height10 * 2),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      var popularIndex =
                                          Get.find<PopularProductControllers>()
                                              .popularProductList
                                              .indexOf(
                                                  _cartList[index].product);
                                      if (popularIndex >= 0) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PopularProductDetail(
                                                    product: Get.find<
                                                                PopularProductControllers>()
                                                            .popularProductList[
                                                        popularIndex]),
                                          ),
                                        );
                                      } else {
                                        var recommendedIndex = Get.find<
                                                RecommendedProductControllers>()
                                            .recommendedProductList
                                            .indexOf(_cartList[index].product);
                                        if (recommendedIndex < 0) {
                                          Get.snackbar("History product",
                                              'Product review is not available');
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RecommendedProductDetail(
                                                      product: Get.find<
                                                                  RecommendedProductControllers>()
                                                              .recommendedProductList[
                                                          recommendedIndex]),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.BASE_URL +
                                                  AppConstants.Upload_URI +
                                                  _cartList[index].img!),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10),
                                  Expanded(
                                    child: SizedBox(
                                      height: Dimensions.height10 * 10,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                            text: controller
                                                .getItems[index].name!,
                                            color: Colors.black45,
                                          ),
                                          SmallText(
                                            text: 'Spicy',
                                            color: Colors.black45,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text:
                                                    '\$ ${controller.getItems[index].price!}',
                                                color: Colors.redAccent,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: Colors.white),
                                                child: Row(
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment.spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      child: const Icon(
                                                          Icons.remove,
                                                          color: Colors.grey),
                                                      onTap: () {
                                                        // decrease product items
                                                        controller
                                                            .addItemToCart(
                                                                _cartList[index]
                                                                    .product!,
                                                                -1);
                                                      },
                                                    ),
                                                    BigText(
                                                      text: _cartList[index]
                                                          .quantity
                                                          .toString(),
                                                      // text: 'controller.inCartSameProductItems.toString()',
                                                      color: Colors.black,
                                                    ),
                                                    GestureDetector(
                                                      child: const Icon(
                                                          Icons.add,
                                                          color: Colors.grey),
                                                      onTap: () {
                                                        // decrease product items
                                                        controller
                                                            .addItemToCart(
                                                                _cartList[index]
                                                                    .product!,
                                                                1);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  )
                : NoDataPage(text: 'Your cart is empty!');
          }),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (controller) {
          var _cartItems = controller.getItems.length;
          return _cartItems > 0 ? Container(
            height: 120,
            padding:
                const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 30),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.grey.shade200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: Dimensions.height10*6,
                  width: Dimensions.width10*10,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Center(
                    child: BigText(
                      text: '\$${controller.totalCartPrice.toInt()}',
                      color: Colors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {

                    controller.addItemsToHistory();
                    // Get.to(CartHistoryPage());
                    /*if(Get.find<AuthController>().userLoggedIn()){
                      controller.addItemsToHistory();
                      Get.to(CartHistoryPage());
                    }else{
                      Get.to(SignInPage());
                    }*/
                  },
                  child: Container(
                    // height: 70,
                    // width: 150,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green),
                    child: BigText(
                      text: 'Checkout',
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ) : Container();
        },
      ),
    );
  }
}
