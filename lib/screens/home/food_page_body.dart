import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivary_app/controller/cart_controller.dart';
import 'package:food_delivary_app/controller/popular_product_controller.dart';
import 'package:food_delivary_app/controller/recommended_product_controller.dart';
import 'package:food_delivary_app/models/product_model.dart';
import 'package:food_delivary_app/routs/rout_helper.dart';
import 'package:food_delivary_app/screens/food/popular_product_detail.dart';
import 'package:food_delivary_app/utils/app_constant.dart';
import 'package:food_delivary_app/widgets/big_text.dart';
import 'package:food_delivary_app/widgets/icon_and_text.dart';
import 'package:food_delivary_app/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';
import '../../widgets/app_food_details.dart';
import '../food/recommended_product_detail.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scalFactor = 0.8;
  double height = Dimensions.pageViewContainer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
        children: [
          // slider section
          GetBuilder<PopularProductControllers>(builder: (controller) {
            return Container(
              height: Dimensions.pageView,
              child: PageView.builder(
                  itemCount: controller. popularProductList.length,
                  controller: pageController,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      onTap: (){
                        CartController.to;
                        Get.to(() => PopularProductDetail(product: controller.popularProductList[position]));
                      },
                      child: _buildPageItem(position,
                          controller.popularProductList[position]),
                    );
                  }),
            );
          }),
          SizedBox(height: Dimensions.height10*2),
          // dot section
          GetBuilder<PopularProductControllers>(builder: (controller) {
            return DotsIndicator(
              // because while loading data dots count being 0
              dotsCount: controller.popularProductList.isEmpty
                  ? 1
                  : controller.popularProductList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeColor: Colors.green,
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          }),
          SizedBox(height: Dimensions.height10*2),
          //text
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                BigText(
                  text: 'Recommended  .  ',
                  color: Colors.black,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: SmallText(
                      text: 'Food pairing',
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
          //list of food with images
          GetBuilder<RecommendedProductControllers>(builder: (controller) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.recommendedProductList.length,
              itemBuilder: (context, index) =>
                  GestureDetector(
                    onTap: (){
                      Get.to(() => RecommendedProductDetail(product: controller.recommendedProductList[index]));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.orangeAccent,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                AppConstants.BASE_URL+AppConstants.Upload_URI+controller
                                      .recommendedProductList[index]
                                      .img!,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 100,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xffe8e8e8),
                                      blurRadius: 5,
                                      offset: Offset(0, 5),
                                    ),
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(5, 0),
                                    ),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    BigText(
                                      text: controller
                                          .recommendedProductList[index]
                                          .name!,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    // comment section
                                    SmallText(
                                      text: 'With chinese characteristics',
                                      color: Colors.grey,
                                    ),
                                    const Spacer(
                                      flex: 3,
                                    ),
                                    // time and distance
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: const [
                                        IconAndText(
                                            icon: Icons.circle_sharp,
                                            text: 'Normal',
                                            color: Colors.grey,
                                            iconColor: Colors.orangeAccent),
                                        IconAndText(
                                            icon: Icons.location_on_outlined,
                                            text: '1.7km',
                                            color: Colors.grey,
                                            iconColor: Colors.green),
                                        IconAndText(
                                            icon: Icons.access_time_sharp,
                                            text: '32min',
                                            color: Colors.grey,
                                            iconColor: Colors.red),
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            );
          })
        ]);
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scalFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scalFactor + (_currPageValue - index + 1) * (1 - _scalFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scalFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - _scalFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: index.isEven
                  ? const Color(0xff69c5df)
                  : const Color(0xff9294cc),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "${AppConstants.BASE_URL}/uploads/${popularProduct
                      .img!}",),),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffe8e8e8),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ]),
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: AppFoodDetails(name: popularProduct.name!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
