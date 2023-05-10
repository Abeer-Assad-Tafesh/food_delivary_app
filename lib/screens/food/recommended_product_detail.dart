import 'package:flutter/material.dart';
import 'package:food_delivary_app/controller/popular_product_controller.dart';
import 'package:food_delivary_app/models/product_model.dart';
import 'package:food_delivary_app/screens/home/main_food_page.dart';
import 'package:food_delivary_app/utils/dimensions.dart';
import 'package:food_delivary_app/widgets/app_icon.dart';
import 'package:food_delivary_app/widgets/big_text.dart';
import 'package:food_delivary_app/widgets/expandable_text.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../utils/app_constant.dart';
import '../../widgets/app_food_details.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';
import '../cart/cart_page.dart';

class RecommendedProductDetail extends StatelessWidget {
  final ProductModel product;

  const RecommendedProductDetail({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    Get.find<PopularProductControllers>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  AppConstants.BASE_URL +
                      AppConstants.Upload_URI +
                      product.img!,
                ),
              )),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => MainFoodPage());
                  },
                  child: const AppIcon(icon: Icons.clear),
                ),
                GetBuilder<PopularProductControllers>(builder: (controller) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>CartPage());
                        },
                        child: AppIcon(icon: Icons.shopping_cart_outlined),),
                      controller.totalItemsInCart >= 1
                          ? const Positioned(
                        top: 0,
                        right: 0,
                        child: AppIcon(
                          icon: Icons.shopping_cart_outlined,
                          size: 20,
                          iconColor: Colors.transparent,
                          backgroundColor: Colors.green,
                        ),
                      )
                          : Container(),
                      controller.totalItemsInCart >= 1
                          ? Positioned(
                          top: 1.5,
                          right: 5,
                          child: BigText(text: controller.totalItemsInCart.toString(),size:10,color: Colors.white,)
                      )
                          : Container(),
                    ],
                  );
                }),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 320,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ), // time and distance
                  BigText(
                    text: product.name!,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableText(text: product.description!),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductControllers>(builder: (controller){
        return  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 40, bottom: 40, left: 50, right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: const AppIcon(
                      icon: Icons.remove,
                      iconColor:Colors.white,
                      backgroundColor: Colors.green,
                      size: 50,
                    ),
                  ),
                  BigText(
                    text: '\$${product.price} X ${controller.inCartSameProductItems}',
                    color: Colors.black,
                    size: 24,
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: const AppIcon(
                      icon: Icons.add,
                      iconColor:Colors.white,
                      backgroundColor: Colors.green,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
                    height: 60,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: const Icon(
                      Icons.favorite_rounded,
                      color: Colors.green,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green),
                      child: BigText(
                        text: '\$${product.price} | Add to cart',
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },),
    );
  }
}
