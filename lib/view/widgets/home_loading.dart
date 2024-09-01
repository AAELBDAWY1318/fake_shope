import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: sizeConfig.screenWidth! * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: sizeConfig.screenHeight! * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[300],
                ),
              ),
              SizedBox(
                height: sizeConfig.screenHeight! * 0.03,
              ),
              Container(
                width: sizeConfig.screenWidth! * 0.2,
                height: sizeConfig.screenHeight! * 0.01,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[300],
                ),
              ),
              SizedBox(
                height: sizeConfig.screenHeight! * 0.02,
              ),
              Container(
                width: sizeConfig.screenWidth! * 0.35,
                height: sizeConfig.screenHeight! * 0.01,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[300],
                ),
              ),
              SizedBox(
                height: sizeConfig.screenHeight! * 0.02,
              ),
              Row(
                children: [
                  Container(
                    width: sizeConfig.screenWidth! * 0.6,
                    height: sizeConfig.screenHeight! * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(
                    width: sizeConfig.screenWidth! * 0.05,
                  ),
                  Expanded(
                    child: Container(
                      width: sizeConfig.screenWidth! * 0.2,
                      height: sizeConfig.screenHeight! * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0),
                        ),
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: sizeConfig.screenHeight! * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    4,
                    (index) => CircleAvatar(
                          radius: sizeConfig.screenWidth! * 0.07,
                        )),
              ),
              SizedBox(
                height: sizeConfig.screenHeight! * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    2,
                    (index) => Container(
                          width: sizeConfig.screenWidth! * 0.4,
                          height: sizeConfig.screenHeight! * 0.27,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.grey[300],
                          ),
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
