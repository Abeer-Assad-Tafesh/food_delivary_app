import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivary_app/screens/home/home_page.dart';
import 'package:food_delivary_app/utils/dimensions.dart';
import 'package:food_delivary_app/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../controller/popular_product_controller.dart';
import '../../controller/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadResources();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      ),
    );
  }

  Future<void> _loadResources() async {
    await Get.find<PopularProductControllers>().getPopularProductList();
    await Get.find<RecommendedProductControllers>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Image.asset('assets/images/food0.png',height: Dimensions.splashImg),
          ),
          BigText(
            text: 'The Best Food',
            color: Colors.green,
            size: Dimensions.font20*1.5,
          )
        ],
      ),
    );
  }
}
