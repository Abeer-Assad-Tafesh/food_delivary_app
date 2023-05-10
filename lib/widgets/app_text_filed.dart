import 'package:flutter/material.dart';
import '../utils/dimensions.dart';

class AppTextFiled extends StatelessWidget {

  final TextEditingController textController;
  final String hintText;
  final bool isObsecure;
  final IconData icon;
  const AppTextFiled({Key? key, required this.textController,
    required this.hintText, required this.icon, this.isObsecure = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius10 * 3),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 7,
              offset: const Offset(1, 7),
              color: Colors.grey.withOpacity(0.2),
            ),
          ]),
      child: TextField(
        controller: textController,
        obscureText: isObsecure,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: Colors.green,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius10 * 3),
            borderSide: const BorderSide(width: 1, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius10 * 3),
            borderSide: const BorderSide(width: 1, color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius10 * 3),
            borderSide: const BorderSide(width: 1, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
