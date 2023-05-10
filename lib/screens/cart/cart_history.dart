import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivary_app/base/no_data__page.dart';
import 'package:food_delivary_app/controller/cart_controller.dart';
import 'package:food_delivary_app/models/cart_model.dart';
import 'package:food_delivary_app/screens/cart/cart_page.dart';
import 'package:food_delivary_app/utils/app_constant.dart';
import 'package:food_delivary_app/utils/dimensions.dart';
import 'package:food_delivary_app/widgets/big_text.dart';
import 'package:food_delivary_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistoryPage extends StatelessWidget {
  const CartHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartHistoryList =
        Get.find<CartController>().getHistoryCartItems().reversed.toList();

    Map<String, int> cartItemsPerOrderMap = {};

    for (int i = 0; i < cartHistoryList.length; i++) {
      if (cartItemsPerOrderMap.containsKey(cartHistoryList[i].time)) {
        cartItemsPerOrderMap.update(cartHistoryList[i].time!, (value) => ++value);
      } else {
        print('===========> ${cartHistoryList[i].time}');
        cartItemsPerOrderMap.putIfAbsent(cartHistoryList[i].time!, () => 1);
      }
    }
    // value
    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrderMap.entries.map((e) => e.value).toList();
    }
    //key
    List<String> cartOrderTimeToList() {
      return cartItemsPerOrderMap.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList(); // ex. [3,1,3]
    var counter = 0;

    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
      if(index < cartHistoryList.length){
       DateTime parseDate =
       DateFormat('yyy-MM-dd HH:mm:ss')
           .parse(cartHistoryList[index].time!);
       var inputDate =
       DateTime.parse(parseDate.toString());
       var outputFormat =
       DateFormat('dd-MM-yyy hh:mm a');
       outputDate = outputFormat.format(inputDate);
     }
      return BigText(text: outputDate,color: Colors.black,size: 16,);
    }

    return Scaffold(
      body: Column(
        children: [
          // app bar
          Container(
            color: Colors.green,
            height: Dimensions.height10 * 10,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height10 * 5,left:  Dimensions.width10 ,right:  Dimensions.width10 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(
                  text: 'Cart History',
                  color: Colors.white,
                ),
                const Icon(Icons.shopping_cart_outlined,color: Colors.white),
              ],
            ),
          ),
          // body
          GetBuilder<CartController>(builder: (controller){
            var _cartItems = controller.getHistoryCartItems().length;
            return _cartItems > 0 ? Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  top: Dimensions.height10 * 2,
                  left: Dimensions.width10 * 2,
                  right: Dimensions.width10 * 2,
                ),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    children: [
                      for (int i = 0; i < itemsPerOrder.length; i++)
                        Container(
                          height: Dimensions.height10 * 12,
                          margin:
                          EdgeInsets.only(bottom: Dimensions.height10 * 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             timeWidget(counter),
                              SizedBox(
                                  height: Dimensions.height10
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemsPerOrder[i],
                                            (index) {
                                          if (counter < cartHistoryList.length) {
                                            counter++;
                                          }
                                          return index <= 2
                                              ? Container(
                                            height: Dimensions.height10 * 8,
                                            width: Dimensions.width10 * 8,
                                            margin: EdgeInsets.only(
                                                right: Dimensions.width10 / 2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    Dimensions.radius10 *
                                                        0.8),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URL +
                                                          AppConstants
                                                              .Upload_URI +
                                                          cartHistoryList[
                                                          counter - 1]
                                                              .img!),
                                                )),
                                          )
                                              : Container();
                                        }),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10 * 8,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        SmallText(text: 'Total',color: Colors.black,),
                                        BigText(
                                          text: '${itemsPerOrder[i].toString()} Items',
                                          color: Colors.black,
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            var orderTime = cartOrderTimeToList();
                                            Map<int, CartModel> moreOrder = {};
                                            for(int j = 0; j<cartHistoryList.length; j++){
                                              if(cartHistoryList[j].time == orderTime[i]){
                                                // moreOrder.putIfAbsent(cartHistoryList[j].id!, () => cartHistoryList[j]);
                                                moreOrder.putIfAbsent(cartHistoryList[j].id!, () =>
                                                    CartModel.fromJson(jsonDecode(jsonEncode(cartHistoryList[j])))
                                                );
                                                Get.find<CartController>().setItems = moreOrder;
                                                Get.find<CartController>().addOneMoreProductsToCart();
                                                Navigator.push(context, MaterialPageRoute(builder: (builder)=> CartPage()));
                                              }
                                            }
                                            // print('order time :${orderTime[x]}');
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.width10,
                                                vertical: Dimensions.height10 / 2),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                    Dimensions.radius10 / 2),
                                                border: Border.all(
                                                    width: 1, color: Colors.green)),
                                            child: SmallText(
                                              text: 'one more',
                                              color: Colors.green,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            )
                : NoDataPage(text: 'You did\'t buy anything so far!');
          }),
        ],
      ),
    );
  }
}
