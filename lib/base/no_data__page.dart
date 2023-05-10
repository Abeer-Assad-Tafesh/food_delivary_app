import 'package:flutter/material.dart';
import 'package:food_delivary_app/utils/dimensions.dart';
import 'package:food_delivary_app/widgets/small_text.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imagePath;
  const NoDataPage({Key? key,
    required this.text,
    this.imagePath = 'assets/images/food0.png'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(imagePath,
          height: MediaQuery.of(context).size.height*0.22,
          width: MediaQuery.of(context).size.width*0.22,
        ),
        SizedBox(height: Dimensions.height10),
        SmallText(text: text,size:16, color: Colors.brown),
      ],
    );
  }
}
