import 'package:food_delivary_app/screens/food/popular_product_detail.dart';
import 'package:food_delivary_app/screens/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String foodDetails = "/food-details";

  static String getInitial() => '$initial';
  static String getFoodDetails() => '$initial';


  static List<GetPage> routs = [
    GetPage(name: initial, page: () => MainFoodPage()),
    // GetPage(
    //   name: foodDetails,
    //   page: () => PopularProductDetail(),
    //   transition: Transition.fadeIn,
    // ),
  ];
}
