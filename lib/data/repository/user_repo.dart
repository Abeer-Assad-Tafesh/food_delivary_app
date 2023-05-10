import 'package:food_delivary_app/data/api/api_client.dart';
import 'package:food_delivary_app/utils/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class UserRepo{
  late ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async{
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }
}