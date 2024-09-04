// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:fake_shope_app/data/models/user_model.dart';
import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:fake_shope_app/utils/helpers/shared_preferences_helper.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:fake_shope_app/utils/route_navigation/routes.dart';
import 'package:fake_shope_app/view/layouts/app_layouts.dart';
import 'package:fake_shope_app/view/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      var prefs = await SharedPreferences.getInstance();
      if (prefs.getString("token") != null) {
        log(prefs.getString("token")!);
        User ? user = await SharedPreferencesHelper().getUser();
        pushReplacement(context, page:  AppLayout(user: user!,));
      } else {
        pushReplacement(context, page: const LoginScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset(
          "assets/images/logoo.png",
          width: sizeConfig.screenWidth! * 0.7,
          height: sizeConfig.screenHeight! * 0.5,
        ),
      ),
    );
  }
}
