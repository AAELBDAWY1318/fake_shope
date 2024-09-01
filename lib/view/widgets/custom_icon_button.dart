import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomIconButton extends StatelessWidget {
  final IconData fontAwesomeIcons;
  final Function() function;
  const CustomIconButton(
      {super.key, required this.fontAwesomeIcons, required this.function});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return CircleAvatar(
      backgroundColor: AppColors.secondaryColor,
      radius: sizeConfig.screenWidth! * 0.07,
      child: IconButton(
        icon: FaIcon(
          fontAwesomeIcons,
          color: Colors.black,
        ),
        onPressed: function,
      ),
    );
  }
}
