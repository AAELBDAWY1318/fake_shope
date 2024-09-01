import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:fake_shope_app/utils/route_navigation/routes.dart';
import 'package:fake_shope_app/view/screens/auth/login.dart';
import 'package:fake_shope_app/view/widgets/custom_button.dart';
import 'package:fake_shope_app/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignUpSuccessScreen extends StatelessWidget {
  const SignUpSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sizeConfig.screenWidth! * 0.05,
          ),
          child: Column(
            children: [
              SizedBox(
                height: sizeConfig.screenHeight! * 0.1,
              ),
              const CustomText(text: "Sign Up Successfully"),
              Expanded(
                child: Center(
                  child: Lottie.asset(
                    "assets/lotties/check.json",
                    repeat: false,
                    width: sizeConfig.screenWidth! * 0.5,
                    height: sizeConfig.screenHeight! * 0.3,
                  ),
                ),
              ),
              CustomButton(
                text: "Login",
                function: () {
                  pushAndRemoveAll(context, page: const LoginScreen());
                },
              ),
              SizedBox(
                height: sizeConfig.screenHeight! * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
