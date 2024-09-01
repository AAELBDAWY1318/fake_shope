import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool ? obscureText;
  final Widget ? suffixIcon;
  const CustomTextForm({super.key, required this.hintText, required this.controller, this.validator, this.obscureText, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      cursorColor: AppColors.primaryColor,
      obscureText: obscureText?? false,
      decoration: InputDecoration(
        hintText: hintText,

        contentPadding: const EdgeInsets.all(15.0),
        fillColor: AppColors.fieldFillColor,
        filled: true,
        
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none, 
        ),
      ),
    );
  }
}
