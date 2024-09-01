import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedError extends StatelessWidget {
  final bool repeat;
  final String text;
  final String asset;
  const AnimatedError(
      {super.key,
      required this.repeat,
      required this.text,
      required this.asset});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            asset,
            width: sizeConfig.screenWidth! * 0.2,
            height: sizeConfig.screenHeight! * 0.2,
            //fit: BoxFit.cover,
            repeat: repeat,
          ),
          Text(
            text,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: (sizeConfig.screenWidth! / 375) * 18,
            ),
          ),
        ],
      ),
    );
  }
}
