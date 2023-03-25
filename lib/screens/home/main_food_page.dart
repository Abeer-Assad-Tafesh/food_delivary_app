import 'package:flutter/material.dart';
import 'package:food_delivary_app/screens/home/food_page_body.dart';
import 'package:food_delivary_app/widgets/big_text.dart';
import '../../widgets/small_text.dart';


class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: const EdgeInsets.only(top: 45,bottom: 15),
              padding:  const EdgeInsets.only(right: 20,left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        BigText(text: 'Country', color: Colors.green,),
                        Row(
                            children: [
                              SmallText(text: 'City',color: Colors.black54,),
                              const Icon(Icons.arrow_drop_down)
                            ]
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green,
                      ),
                    child: const Icon(Icons.search,color: Colors.white,),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
              child: SingleChildScrollView(
                  child: FoodPageBody(),
              ),
          ),
        ],
      ),
    );
  }
}
