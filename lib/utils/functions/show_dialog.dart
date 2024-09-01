import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:fake_shope_app/utils/route_navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.fieldFillColor,
          content: LoadingAnimationWidget.dotsTriangle(
              color: AppColors.primaryColor, size: 50.0),
        );
      });
}

void showErrorDialog(BuildContext context, String error) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.fieldFillColor,
          actions: [
            TextButton(
                onPressed: () {
                  pop(context);
                },
                child: Text(
                  "ok",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ))
          ],
          content: Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryColor,
            ),
          ),
        );
      });
}
