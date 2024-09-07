import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String image, name;
  final double price;
  final Function() onTap;
  const CartItem(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Image.network(
              image,
              width: sizeConfig.screenWidth! * 0.3,
              height: sizeConfig.screenHeight! * 0.14,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            width: sizeConfig.screenWidth! * 0.03,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: (sizeConfig.screenWidth! / 375) * 16,
                      overflow: TextOverflow.ellipsis),
                ),
                Text(
                  "$price \$",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: (sizeConfig.screenWidth! / 375) * 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
