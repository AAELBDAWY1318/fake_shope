import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  final Function() onTap;
  final String image, name;
  const EditProfile(
      {super.key,
      required this.onTap,
      required this.image,
      required this.name});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60.0),
            ),
            child: Image.network(
              image,
              width: sizeConfig.screenWidth! * 0.2,
              height: sizeConfig.screenHeight! * 0.1,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: sizeConfig.screenWidth! * 0.03,
          ),
          Column(
            children: [
              Text(
                "Hello, $name",
                style: TextStyle(
                  fontSize: (sizeConfig.screenWidth! / 375) * 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const Text(
                "Edit Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
