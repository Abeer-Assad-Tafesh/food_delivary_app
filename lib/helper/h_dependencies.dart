import 'package:food_delivary_app/controller/auth_controller.dart';
import 'package:food_delivary_app/controller/cart_controller.dart';
import 'package:food_delivary_app/controller/popular_product_controller.dart';
import 'package:food_delivary_app/controller/recommended_product_controller.dart';
import 'package:food_delivary_app/data/api/api_client.dart';
import 'package:food_delivary_app/data/repository/auth_repo.dart';
import 'package:food_delivary_app/data/repository/popular_product_repo.dart';
import 'package:food_delivary_app/data/repository/recommended_product_repo.dart';
import 'package:food_delivary_app/data/repository/user_repo.dart';
import 'package:food_delivary_app/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/user_controller.dart';
import '../data/repository/cart_repo.dart';


// this method is called on main method for reloading data
Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL,sharedPreferences: Get.find()));
  //repos
//  تم تخزين ApiClient في الكود فوق في getX , فاحنا بنستدعيها من getX باستخدام () Get.find
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductControllers(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductControllers(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
