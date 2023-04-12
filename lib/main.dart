import 'package:flutter/material.dart';
import 'package:food_delivary_app/controller/popular_product_controller.dart';
import 'package:food_delivary_app/screens/food/popular_product_detail.dart';
import 'package:food_delivary_app/screens/home/main_food_page.dart';
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
    Get.find<PopularProductControllers>().getPopularProductList();

    return GetMaterialApp(
      theme: ThemeData(
          primaryColor: Colors.red,
          ),
      debugShowCheckedModeBanner: false,
      home: MainFoodPage(),
        // PopularFoodDetail()
    );
  }
}

