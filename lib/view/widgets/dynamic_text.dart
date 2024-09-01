import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:flutter/material.dart';

class DynamicText extends StatelessWidget {
  final int ? maxLines;
  final String text;
  final Function() onTap;
  const DynamicText(
      {super.key,
      this.maxLines,
      required this.text,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text,
            maxLines: maxLines,
            overflow: TextOverflow.fade,
          ),
          Container(
            width: double.infinity,
            height: sizeConfig.screenHeight! * 0.07,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.grey[100]!,
                    ])),
            child: Icon(
              Icons.arrow_drop_down,
              size: 30.0,
              color: AppColors.primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
