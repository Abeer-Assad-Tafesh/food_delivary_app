import 'package:flutter/material.dart';
import 'package:food_delivary_app/widgets/app_icon.dart';
import 'package:food_delivary_app/widgets/big_text.dart';
import 'package:food_delivary_app/widgets/expandable_text.dart';

import '../../widgets/app_food_details.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 350,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/food0.png'),
              )),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                AppIcon(icon: Icons.arrow_back_ios),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 320,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const AppFoodDetails(),
                  const SizedBox(
                    height: 20,
                  ), // time and distance
                  BigText(
                      text: 'Introduce',
                      color: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                    const Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableText(text: "dbhcghjb ygdahsgha dbhcghjb  hgfkg ygdahsgha dbhcghjb jhgk"
                          " ygdahsgha dbhcghjb ygdahsgha dbhcghjb ygdahsgha jgjhbjh kjkm"
                          " ygdahsgha dbhcghjb ygdahsgha dbhcghjb ygdahsgha jgjhbjh kjkm"
                          " ygdahsgha dbhcghjb ygdahsgha dbhcghjb ygdahsgha jgjhbjh kjkm"
                          " ygdahsgha dbhcghjb ygdahsgha dbhcghjb ygdahsgha jgjhbjh kjkm"
                          " ygdahsgha dbhcghjb ygdahsgha dbhcghjb ygdahsgha jgjhbjh kjkm"
                          " ygdahsgha dbhcghjb ygdahsgha dbhcghjb ygdahsgha jgjhbjh kjkm"
                          "dbhcghjb ygdahsgha dbhcghjb hgkhj uhlj luhui ygdahsgha dbhcghjb ygdahsgha hjbgkyg"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 120,
        padding: const EdgeInsets.only(top:30,right: 20,left: 20,bottom: 30),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.grey.shade400
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 70,
              width: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.remove),
                  BigText(text: '0',color: Colors.black,),
                  Icon(Icons.add),
                ],
              ),
            ),
            Container(
              height: 70,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green
              ),
              child: BigText(text: 'Add to cart',size: 16, color: Colors.white,),

            )
          ],
        ),
      ),
    );
  }
}
