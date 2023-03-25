import 'package:flutter/material.dart';
import 'package:food_delivary_app/widgets/small_text.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = 150;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              text: firstHalf,
              color: Colors.grey,
              height: 1.5,
              overflow: TextOverflow.visible,
              size: 14,
            )
          : Column(
              children: [
                SmallText(text: hiddenText ? '$firstHalf...' : firstHalf+secondHalf,
                  overflow: TextOverflow.visible,
                  color: Colors.grey,
                  height: 1.5,
                  size: 14,
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      // if it true it will be false & visa versa
                      hiddenText =! hiddenText;
                    });
                  },
                    child: Row(
                      children: [
                        SmallText(text: hiddenText ?  'Show more' : 'Show less',color: Colors.green,),
                        Icon(hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up,color: Colors.green,)
                      ],
                    ),
                )
              ],
            ),
    );
  }
}
