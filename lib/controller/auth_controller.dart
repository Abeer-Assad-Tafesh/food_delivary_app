import 'package:food_delivary_app/data/repository/auth_repo.dart';
import 'package:food_delivary_app/models/response_model.dart';
import 'package:food_delivary_app/models/signup_body.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({required this.authRepo,});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late ResponseModel responseModel;

  Future<ResponseModel> registration(SignUpBody signUpBody) async{

    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async{
    _isLoading = true;
    update();
    Response response = await authRepo.login(email,password);
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserPhoneAndPassword(String phone, String password) {
    authRepo.saveUserPhoneAndPassword(phone, password);
  }

  bool userLoggedIn(){
    return authRepo.userLoggedIn();
  }

  bool clearShredData(){
    return authRepo.clearSharedData();
  }
}