import 'package:flutter/material.dart';
import 'package:food_delivary_app/controller/cart_controller.dart';
import 'package:food_delivary_app/controller/popular_product_controller.dart';
import 'package:food_delivary_app/controller/recommended_product_controller.dart';
import 'package:food_delivary_app/routs/rout_helper.dart';
import 'package:food_delivary_app/screens/food/popular_product_detail.dart';
import 'package:food_delivary_app/screens/home/home_page.dart';
import 'package:food_delivary_app/screens/home/main_food_page.dart';
import 'package:food_delivary_app/screens/home/splash_screen.dart';
import 'package:get/get.dart';
import 'helper/h_dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('============== start here ================');
    Get.find<CartController>().getCart();
    return GetBuilder<PopularProductControllers>(builder: (_) {
      return GetBuilder<RecommendedProductControllers>(builder: (_) {
        print('============== end here ================');
        return GetMaterialApp(
            theme: ThemeData(
              primaryColor: Colors.red,
            ),
            debugShowCheckedModeBanner: false,
            home: SplashScreen()
            // HomePage(),
            // PopularFoodDetail()
            );
      });
    });
  }
}
