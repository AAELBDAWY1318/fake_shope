import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class CustomOtpField extends StatelessWidget {
  final Function(String val)? onSubmit;
  const CustomOtpField({super.key, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return OtpTextField(
      numberOfFields: 4,
      borderRadius: BorderRadius.circular(20.0),
      borderWidth: 0.0,
      showFieldAsBox: true,
      fillColor: AppColors.fieldFillColor,
      filled: true,
      focusedBorderColor: AppColors.primaryColor,
      cursorColor: AppColors.primaryColor,
      fieldWidth: sizeConfig.screenWidth! * 0.15,
      textStyle: TextStyle(color: AppColors.primaryColor),
      onSubmit: onSubmit,
    );
  }
}
