import 'package:food_delivary_app/controller/popular_product_controller.dart';
import 'package:food_delivary_app/data/api/api_client.dart';
import 'package:food_delivary_app/data/repository/popular_product_repo.dart';
import 'package:food_delivary_app/utils/app_constant.dart';
import 'package:get/get.dart';

Future<void> init() async {

Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

// تم تخزين ApiClient فوق في getX , فاحنا بنستدعيها من getX باستخدام  Get.find()0
Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

Get.lazyPut(() => PopularProductControllers(popularFoodRepo: Get.find()));


}