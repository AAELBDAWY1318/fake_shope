import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String image, name, price;
  final Function() onTap;
  const CustomCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 1.8,
        shadowColor: AppColors.secondaryColor,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: sizeConfig.screenHeight! * 0.01,
              horizontal: sizeConfig.screenWidth! * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                image,
                fit: BoxFit.contain,
                height: sizeConfig.screenHeight! * 0.15,
                width: sizeConfig.screenWidth! * 0.35,
              ),
              SizedBox(
                height: sizeConfig.screenHeight! * 0.01,
              ),
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
              SizedBox(
                height: sizeConfig.screenHeight! * 0.01,
              ),
              const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "4.9",
                  ),
                  Icon(Icons.star_half)
                ],
              ),
              Text(
                price,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
