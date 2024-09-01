import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:flutter/material.dart';

class BannerItem extends StatelessWidget {
  final String image;
  const BannerItem({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return Container(
      width: sizeConfig.screenWidth! * 0.7,
      height: sizeConfig.screenHeight! * 0.18,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
