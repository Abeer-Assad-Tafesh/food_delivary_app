import 'package:food_delivary_app/data/api/api_client.dart';
import 'package:food_delivary_app/models/signup_body.dart';
import 'package:food_delivary_app/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  // registration is a built in method
  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.REGISTRATION_URI, signUpBody.toJason());
  }

  // login is a built in method
  Future<Response> login(String email, String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, {"email":email,"password":password});
  }

  saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  bool userLoggedIn(){
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }
  Future<String> getUserToken() async {
     return await sharedPreferences.getString(AppConstants.TOKEN) ?? "None";
  }

  Future<void> saveUserPhoneAndPassword(String phone, String password) async {
    try{
      await sharedPreferences.setString(AppConstants.PHONE,phone);
      await sharedPreferences.setString(AppConstants.PASSWORD,password);
    }catch(e){
      throw e;
    }
  }


  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
