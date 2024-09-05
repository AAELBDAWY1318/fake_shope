import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:flutter/material.dart';

class DetailsComponent extends StatelessWidget {
  final String str1, str2;
  const DetailsComponent({super.key, required this.str1, required this.str2});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return Row(
      children: [
        Text(
          "$str1:     ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: (sizeConfig.screenWidth! / 375) * 16,
          ),
        ),
        Expanded(
          child: Text(
            str2,
            style: TextStyle(
              fontSize: (sizeConfig.screenWidth! / 375) * 16,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
