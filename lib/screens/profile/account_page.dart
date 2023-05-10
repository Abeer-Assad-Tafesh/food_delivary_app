import 'package:flutter/material.dart';
import 'package:food_delivary_app/controller/auth_controller.dart';
import 'package:food_delivary_app/controller/cart_controller.dart';
import 'package:food_delivary_app/controller/user_controller.dart';
import 'package:food_delivary_app/screens/auth/sign_in_page.dart';
import 'package:food_delivary_app/screens/home/home_page.dart';
import 'package:food_delivary_app/utils/dimensions.dart';
import 'package:food_delivary_app/widgets/account_widget.dart';
import 'package:food_delivary_app/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../widgets/app_icon.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().gstUserInfo();
      print('user info come');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: BigText(
          text: 'Profile',
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn ? (SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Dimensions.height10 * 3),
              AppIcon(
                icon: Icons.person,
                backgroundColor: Colors.green,
                iconColor: Colors.white,
                iconSize: Dimensions.height10 * 7 + 5,
                size: Dimensions.height10 * 15,
              ),
              SizedBox(height: Dimensions.height10 * 3),
              AccountWidget(
                appIcon: AppIcon(
                  icon: Icons.person,
                  backgroundColor: Colors.green,
                  iconColor: Colors.white,
                  iconSize: Dimensions.height10 *3,
                  size: Dimensions.height10 * 6,
                ),
                text: BigText(text: userController.userModel.name, color: Colors.black),
              ),
              SizedBox(height: Dimensions.height10 * 2),
              AccountWidget(
                appIcon: AppIcon(
                  icon: Icons.phone,
                  backgroundColor: Colors.green,
                  iconColor: Colors.white,
                  iconSize: Dimensions.height10 *3,
                  size: Dimensions.height10 * 6,
                ),
                text: BigText(text:  userController.userModel.phone, color: Colors.black),
              ),
              SizedBox(height: Dimensions.height10 * 2),
              AccountWidget(
                appIcon: AppIcon(
                  icon: Icons.email,
                  backgroundColor: Colors.green,
                  iconColor: Colors.white,
                  iconSize: Dimensions.height10 *3,
                  size: Dimensions.height10 * 6,
                ),
                text: BigText(text:  userController.userModel.email, color: Colors.black),
              ),
              SizedBox(height: Dimensions.height10 * 2),
              AccountWidget(
                appIcon: AppIcon(
                  icon: Icons.location_on,
                  backgroundColor: Colors.green,
                  iconColor: Colors.white,
                  iconSize: Dimensions.height10 *3,
                  size: Dimensions.height10 * 6,
                ),
                text: BigText(text: 'Fill in your address',  color: Colors.black),
              ),
              SizedBox(height: Dimensions.height10 * 2),
              AccountWidget(
                appIcon: AppIcon(
                  icon: Icons.message,
                  backgroundColor: Colors.green,
                  iconColor: Colors.white,
                  iconSize: Dimensions.height10 *3,
                  size: Dimensions.height10 * 6,
                ),
                text: BigText(text: 'Messages', color: Colors.black),
              ),
              SizedBox(height: Dimensions.height10 * 2),
              GestureDetector(
                onTap: (){
                  if(Get.find<AuthController>().userLoggedIn()){
                    Get.find<AuthController>().clearShredData();
                    Get.find<CartController>().clear();
                    Get.find<CartController>().clearCartHistory();
                    Get.to(HomePage());
                  }
                },
                child: AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.logout,
                    backgroundColor: Colors.redAccent,
                    iconColor: Colors.white,
                    iconSize: Dimensions.height10 *3,
                    size: Dimensions.height10 * 6,
                  ),
                  text: BigText(text: 'Logout', color: Colors.black),
                ),
              ),
              SizedBox(height: Dimensions.height10 * 2),
            ],
          ),
        )) : Center(child: Text('you must login'),);
      },)
    );
  }
}
