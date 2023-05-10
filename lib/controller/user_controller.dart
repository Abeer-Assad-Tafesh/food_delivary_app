import 'package:food_delivary_app/data/repository/auth_repo.dart';
import 'package:food_delivary_app/models/response_model.dart';
import 'package:food_delivary_app/models/signup_body.dart';
import 'package:food_delivary_app/models/user_model.dart';
import 'package:get/get.dart';
import '../data/repository/user_repo.dart';

class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;

  UserController({required this.userRepo,});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late ResponseModel responseModel;
  late UserModel _userModel;
  UserModel get userModel => _userModel;

  Future<ResponseModel> gstUserInfo() async{
    Response response = await userRepo.getUserInfo();
    if(response.statusCode == 200){
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, 'successful');
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}