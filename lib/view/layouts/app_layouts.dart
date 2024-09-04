import 'dart:developer';

import 'package:fake_shope_app/data/models/user_model.dart';
import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:fake_shope_app/utils/helpers/shared_preferences_helper.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:fake_shope_app/utils/route_navigation/routes.dart';
import 'package:fake_shope_app/view/screens/home_screen/home_screen.dart';
import 'package:fake_shope_app/view/screens/home_screen/profile.dart';
import 'package:fake_shope_app/view/screens/watchlist_screen.dart';
import 'package:fake_shope_app/view/widgets/edit_profile.dart';
import 'package:fake_shope_app/view/widgets/sparate_line.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatefulWidget {
  final User user;
  const AppLayout({super.key, required this.user});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int index = 0;
  List<Widget> screens = [const HomeScreen(), const ProfileScreen()];
  Future<bool> onWillPop() async {
    if (index == 1) {
      // If the current screen is Profile
      setState(() {
        index = 0; // Switch to Home
      });
      return false; // Prevent the app from exiting
    }
    return true; // Allow the app to exit
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leadingWidth: sizeConfig.screenWidth! * 0.165,
          backgroundColor: Colors.white,
          elevation: 0.0,
          foregroundColor: Colors.black,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: sizeConfig.screenWidth! * 0.03),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_basket_sharp)),
            ),
          ],
        ),
        drawer: Drawer(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: sizeConfig.screenWidth! * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: sizeConfig.screenHeight! * 0.02,
                ),
                Image.asset(
                  "assets/images/logoo.png",
                  height: sizeConfig.screenHeight! * 0.2,
                  width: sizeConfig.screenWidth! * 0.2,
                  fit: BoxFit.cover,
                ),
                EditProfile(onTap: () {}, image: widget.user.image, name: widget.user.name),
                SizedBox(
                  height: sizeConfig.screenHeight! * 0.02,
                ),
                const CustomLine(),
                ListTile(
                  leading: Icon(
                    Icons.notifications,
                    size: sizeConfig.screenWidth! * 0.08,
                  ),
                  title: const Text('Notification'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.favorite,
                    size: sizeConfig.screenWidth! * 0.08,
                    color: AppColors.primaryColor,
                  ),
                  title: const Text('Watchlist'),
                  onTap: () {
                    push(context, page: const FavoriteScreen());
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    size: sizeConfig.screenWidth! * 0.08,
                  ),
                  title: const Text('Orders'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.account_balance_wallet,
                    size: sizeConfig.screenWidth! * 0.08,
                  ),
                  title: const Text('Wallet'),
                  onTap: () {},
                ),
                 ListTile(
                  leading: Icon(
                    Icons.settings,
                    size: sizeConfig.screenWidth! * 0.08,
                  ),
                  title: const Text('Setting'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    size: sizeConfig.screenWidth! * 0.08,
                    color: AppColors.primaryColor,
                  ),
                  title: const Text('Log Out'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
          currentIndex: index,
          selectedItemColor: AppColors.primaryColor,
          onTap: (val) {
            index = val;
            setState(() {});
          },
        ),
        body: screens[index],
      ),
    );
  }
}
