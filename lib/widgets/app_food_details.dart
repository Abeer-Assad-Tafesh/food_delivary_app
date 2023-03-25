import 'package:flutter/material.dart';
import 'package:food_delivary_app/widgets/small_text.dart';

import 'big_text.dart';
import 'icon_and_text.dart';

class AppFoodDetails extends StatelessWidget {
  const AppFoodDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: 'Chinese Side',
          color: Colors.black,
          size: 16,
        ),
        const SizedBox(height: 10,),// time and distance
        // comment section
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                      (index) => const Icon(
                    Icons.star,
                    size: 15,
                    color: Colors.green,
                  )),
            ),
            const SizedBox(width: 10),
            SmallText(
              text: '4.5',
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            SmallText(
              text: '1287',
              color: Colors.grey,
            ),
            const SizedBox(
              width: 3,
            ),
            SmallText(
              text: 'comments',
              color: Colors.grey,
            ),
          ],
        ),
        const SizedBox(height: 20,),// time and distance
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconAndText(
                icon: Icons.circle_sharp,
                text: 'Normal',
                color: Colors.grey,
                iconColor: Colors.orangeAccent),
            IconAndText(
                icon: Icons.location_on_outlined,
                text: '1.7km',
                color: Colors.grey,
                iconColor: Colors.green),
            IconAndText(
                icon: Icons.access_time_sharp,
                text: '32min',
                color: Colors.grey,
                iconColor: Colors.red),
          ],
        ),

      ],
    );
  }
}