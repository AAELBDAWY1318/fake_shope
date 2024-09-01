import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  const CustomText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return Text(
      text,
      style: TextStyle(
        fontSize: (sizeConfig.screenWidth! / 375) * 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
