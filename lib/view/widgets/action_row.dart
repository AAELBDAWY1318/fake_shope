import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:flutter/material.dart';
class CustomActionRow extends StatelessWidget {
  final String text1, text2;
  final Function() function;
  const CustomActionRow(
      {super.key,
      required this.text1,
      required this.text2,
      required this.function});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
         text1,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: sizeConfig.screenHeight! * 0.028,
            color: Colors.grey,
          ),
        ),
        TextButton(onPressed: function, child: Text(
          text2, 
          style: TextStyle(
            color: AppColors.primaryColor,
          ),
        )),
      ],
    );
  }
}
