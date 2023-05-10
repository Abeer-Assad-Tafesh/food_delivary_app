import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivary_app/base/custom_loader.dart';
import 'package:food_delivary_app/controller/auth_controller.dart';
import 'package:food_delivary_app/models/signup_body.dart';
import 'package:food_delivary_app/screens/home/home_page.dart';
import 'package:food_delivary_app/utils/dimensions.dart';
import 'package:food_delivary_app/widgets/app_text_filed.dart';
import 'package:food_delivary_app/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      'facebook.svg',
      'instagram.svg',
      'tiktok.svg',
    ];

    void _registration(AuthController authController){
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      String email = emailController.text.trim();
      if(name.isEmpty){
        showCustomSnackBar('Type in your name',title: 'Name');
      }else if(phone.isEmpty){
        showCustomSnackBar('Type in your phone number',title: 'Phone');
      }else if(email.isEmpty){
        showCustomSnackBar('Type in your email',title: 'Email');
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar('Type in a valid email',title: 'Email');
      }else if(password.isEmpty){
        showCustomSnackBar('Type in your password',title: 'Password');
      }else if(password.length<6){
        showCustomSnackBar('Password can\'t be less than 6 characters',title: 'Password');
      }else{

        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        print(signUpBody.toString());
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            // showCustomSnackBar('All went well',title: 'Perfect!');
            Get.to(HomePage());
            showCustomSnackBar('Success Signup');
            print('Success Auth');
          }else{
            showCustomSnackBar(status.message);
            print('======================> Faild Auth=====>>${status.message}');
          }
        });
      }
    }

    return Scaffold(
      body: GetBuilder<AuthController>(builder: (_authController){
        return _authController.isLoading ? const CustomLoader()
            : SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: Dimensions.height10 * 7),
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: Dimensions.height10 * 8,
                    backgroundImage: const AssetImage('assets/images/food1.png'),
                  ),
                ),
                SizedBox(height: Dimensions.height10 * 4),
                AppTextFiled(
                  textController: nameController,
                  hintText: 'Name',
                  icon: Icons.person,
                ),
                SizedBox(height: Dimensions.height10 * 2),
                AppTextFiled(
                  textController: phoneController,
                  hintText: 'Phone',
                  icon: Icons.phone_android_rounded,
                ),
                SizedBox(height: Dimensions.height10 * 2),
                AppTextFiled(
                  textController: emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                ),
                SizedBox(height: Dimensions.height10 * 2),
                AppTextFiled(
                  textController: passwordController,
                  hintText: 'Password',
                  isObsecure: true,
                  icon: Icons.password_sharp,
                ),
                SizedBox(height: Dimensions.height10 * 2),
                GestureDetector(
                  onTap: (){
                    _registration(_authController);
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
                      text: 'Sign up',
                      size: Dimensions.font20 * 1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10 * 2),
                RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                    text: 'Have an account already?',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10 * 2),
                RichText(
                  text: TextSpan(
                    text: 'Sign up using one of the following methods',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20 * 0.75,
                    ),
                  ),
                ),
                // Wrap(
                //   children: List.generate(
                //     3,
                //         (index) => SvgPicture.asset(
                //         'assets/icons/${signUpImages[index]}',
                //           color: Colors.green,
                //           width: 20,
                //           height: 20,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
