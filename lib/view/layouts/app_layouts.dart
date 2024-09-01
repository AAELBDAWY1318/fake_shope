import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:fake_shope_app/view/screens/home_screen/home_screen.dart';
import 'package:fake_shope_app/view/screens/home_screen/profile.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

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
        drawer: const Drawer(),
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
