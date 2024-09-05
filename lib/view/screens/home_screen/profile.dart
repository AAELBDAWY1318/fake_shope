import 'package:fake_shope_app/data/models/user_model.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:fake_shope_app/utils/route_navigation/routes.dart';
import 'package:fake_shope_app/view/screens/edit_profile.dart';
import 'package:fake_shope_app/view/widgets/custom_button.dart';
import 'package:fake_shope_app/view/widgets/details_component.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: sizeConfig.screenWidth! * 0.05),
        child: Column(
          children: [
            Center(
              child: Container(
                width: sizeConfig.screenWidth! * 0.3,
                height: sizeConfig.screenHeight! * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Image.network(
                  user.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: sizeConfig.screenHeight! * 0.03,
            ),
            DetailsComponent(str1: "User Name", str2: user.name),
            SizedBox(
              height: sizeConfig.screenHeight! * 0.03,
            ),
            DetailsComponent(str1: "Email", str2: user.email),
            SizedBox(
              height: sizeConfig.screenHeight! * 0.03,
            ),
            DetailsComponent(str1: "Phone Number", str2: user.phone),
            const Spacer(),
            CustomButton(
                text: "Edit Profile",
                function: () {
                  push(context, page: EditProfileScreen(user: user));
                }),
          ],
        ),
      ),
    );
  }
}
