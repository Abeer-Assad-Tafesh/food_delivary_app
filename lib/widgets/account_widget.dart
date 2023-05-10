import 'package:flutter/material.dart';
import 'package:food_delivary_app/utils/dimensions.dart';
import 'package:food_delivary_app/widgets/app_icon.dart';
import 'package:food_delivary_app/widgets/big_text.dart';
class AccountWidget extends StatelessWidget {

  AppIcon appIcon;
  BigText text;
  AccountWidget({Key? key, required this.appIcon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimensions.width10 * 2,
          top: Dimensions.width10, bottom: Dimensions.width10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: const Offset(0,2),
            color: Colors.grey.withOpacity(0.2)
          )
        ]
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width10 * 2),
          text,
        ],
      ),
    );
  }
}
