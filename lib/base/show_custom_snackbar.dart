

import 'package:food_delivary_app/widgets/big_text.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message,{bool isError = true, String title = 'error'}){
  Get.snackbar(title, message,);
}
