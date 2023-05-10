import 'package:flutter/material.dart';
import 'package:food_delivary_app/utils/dimensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimensions.height10 * 10,
        width: Dimensions.width10 * 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius10*5),
          color: Colors.green,
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
