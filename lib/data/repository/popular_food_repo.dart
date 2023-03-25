import 'package:food_delivary_app/data/api/api_client.dart';
import 'package:food_delivary_app/utils/app_constant.dart';
import 'package:get/get.dart';

class PopularFoodRepo extends GetxService{

  final ApiClient apiClient;

  PopularFoodRepo({required this.apiClient});

  Future<Response> getPopularFoodList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }

}