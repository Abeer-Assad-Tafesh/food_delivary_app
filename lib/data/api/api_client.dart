import 'package:food_delivary_app/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 1- Api client deals with server (get/post requests)  =>  2- repos
class ApiClient extends GetConnect implements GetxService{

  late String token;
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;
  late Map<String,String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}){
    // appBaseUrl is stored to getX internally
    baseUrl = appBaseUrl;
    // timeout = const Duration(seconds: 30);
    token = AppConstants.TOKEN ;
    // token = sharedPreferences.getString(AppConstants.TOKEN)! ;
    _mainHeaders = {
      'Content-type' : 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer $token'
    };
  }

  void updateHeader(String token){
    _mainHeaders = {
      'Content-type' : 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer $token'
    };
  }

  // built in getX method
  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try{
      Response response =  await get(uri,headers: headers??_mainHeaders);
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  // the body is user json
  Future<Response> postData(String url,dynamic body) async {
    print('================>   body.toString() ====>${body.toString()}');
    try{
      Response response = await post(url, body, headers: _mainHeaders);
      print('========================> response.body ====>${response.body}');
      // server return user auth token
      return response;
    }catch(e){
      print('=====================> error is-======> ${e.toString()}' );
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}