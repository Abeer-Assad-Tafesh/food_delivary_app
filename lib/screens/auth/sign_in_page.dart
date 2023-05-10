import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivary_app/base/custom_loader.dart';
import 'package:food_delivary_app/screens/auth/sign_up_page.dart';
import 'package:food_delivary_app/screens/home/home_page.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controller/auth_controller.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_filed.dart';
import '../../widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController){
      String password = passwordController.text.trim();
      String email = emailController.text.trim();
      if(email.isEmpty){
        showCustomSnackBar('Type in your email',title: 'Email');
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar('Type in a valid email',title: 'Email');
      }else if(password.isEmpty){
        showCustomSnackBar('Type in your password',title: 'Password');
      }else if(password.length<6){
        showCustomSnackBar('Password can\'t be less than 6 characters',title: 'Password');
      }else{
        authController.login(email,password).then((status){
          if(status.isSuccess){
            Get.to(HomePage());
            // showCustomSnackBar('All went well',title: 'Perfect!');
            showCustomSnackBar('Success Sign in');
            print('Success Auth');
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      body: GetBuilder<AuthController>(builder: (_authController){
        return _authController.isLoading ? CustomLoader()
            :SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.height10 * 3),
              //logo
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: Dimensions.height10 * 8,
                  backgroundImage: const AssetImage('assets/images/ob4.svg'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width10 * 2),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello',
                      style: TextStyle(
                          fontSize: Dimensions.font20 * 3.5,
                          fontWeight: FontWeight.bold),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Sign into your account',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height10 * 4),
              AppTextFiled(
                textController: emailController,
                hintText: 'Email',
                icon: Icons.email,
              ),
              SizedBox(height: Dimensions.height10 * 2),
              AppTextFiled(
                textController: passwordController,
                hintText: 'Password',
                icon: Icons.password_sharp,
              ),
              SizedBox(height: Dimensions.height10 * 5),
              //sign in btn
              GestureDetector(
                onTap: (){
                  _login(_authController);
                },
                child: Container(
                  height:Dimensions.height10*6,
                  width: Dimensions.width10 *20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius10 * 3),
                    color: Colors.green,
                  ),
                  child: BigText(
                    text: 'Sign in',
                    size: Dimensions.font20 * 1.5,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10 * 2),
              RichText(
                text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(()=>SignUpPage(),transition: Transition.fade),
                        text: 'Create',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.font20,
                        ),
                      ),
                    ]),
              ),
              SizedBox(height: Dimensions.height10 * 2),
            ],
          ),
        );
      },)
    );
  }
}
