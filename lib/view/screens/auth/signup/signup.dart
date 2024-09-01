import 'dart:developer';

import 'package:fake_shope_app/data/data_source/remote_data/auth_repository.dart';
import 'package:fake_shope_app/data/models/user_model.dart';
import 'package:fake_shope_app/logic/auth_bloc/auth_bloc.dart';
import 'package:fake_shope_app/utils/functions/confirm_password_validation.dart';
import 'package:fake_shope_app/utils/functions/email_validation.dart';
import 'package:fake_shope_app/utils/functions/password_validation.dart';
import 'package:fake_shope_app/utils/functions/phone_validation.dart';
import 'package:fake_shope_app/utils/functions/show_dialog.dart';
import 'package:fake_shope_app/utils/functions/username_validation.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:fake_shope_app/utils/route_navigation/routes.dart';
import 'package:fake_shope_app/view/screens/auth/signup/signup_success.dart';
import 'package:fake_shope_app/view/widgets/action_row.dart';
import 'package:fake_shope_app/view/widgets/custom_button.dart';
import 'package:fake_shope_app/view/widgets/custom_text.dart';
import 'package:fake_shope_app/view/widgets/sparate_line.dart';
import 'package:fake_shope_app/view/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obscureText1 = true, obscureText2 = true;
  IconData icon1 = Icons.visibility_off, icon2 = Icons.visibility_off;
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return BlocProvider(
      create: (context) => AuthBloc(AuthRepository()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            log(state.token);
            pop(context);
            push(context, page: const SignUpSuccessScreen());
          } else if (state is SignUpWaiting) {
            showLoadingDialog(context);
          } else if (state is SignUpFailure) {
            pop(context);
            showErrorDialog(context, state.message);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: sizeConfig.screenWidth! * 0.05),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Image.asset(
                                "assets/images/logoo.png",
                                width: sizeConfig.screenWidth! * 0.5,
                                height: sizeConfig.screenHeight! * 0.3,
                              ),
                            ),
                            const CustomText(text: "CREATE YOUR \nACCOUNT"),
                          ],
                        ),
                        SizedBox(
                          height: sizeConfig.screenHeight! * 0.02,
                        ),
                        CustomTextForm(
                          hintText: "Email",
                          controller: email,
                          validator: validateEmail,
                        ),
                        SizedBox(
                          height: sizeConfig.screenHeight! * 0.02,
                        ),
                        CustomTextForm(
                          hintText: "User Name",
                          controller: name,
                          validator: validateUsername,
                        ),
                        SizedBox(
                          height: sizeConfig.screenHeight! * 0.02,
                        ),
                        CustomTextForm(
                          hintText: "phone",
                          controller: phone,
                          validator: validateEgyptianPhoneNumber,
                        ),
                        SizedBox(
                          height: sizeConfig.screenHeight! * 0.02,
                        ),
                        CustomTextForm(
                          hintText: "Password",
                          controller: password,
                          obscureText: obscureText2,
                          suffixIcon: IconButton(
                            icon: Icon(icon2),
                            onPressed: () {
                              obscureText2 = !obscureText2;
                              if (icon2 == Icons.visibility_off) {
                                icon2 = Icons.visibility;
                              } else {
                                icon2 = Icons.visibility_off;
                              }
                              setState(() {});
                            },
                          ),
                          validator: validatePassword,
                        ),
                        SizedBox(
                          height: sizeConfig.screenHeight! * 0.02,
                        ),
                        CustomTextForm(
                          hintText: "Confirm Password",
                          controller: rePassword,
                          obscureText: obscureText1,
                          suffixIcon: IconButton(
                            icon: Icon(icon1),
                            onPressed: () {
                              obscureText1 = !obscureText1;
                              if (icon1 == Icons.visibility_off) {
                                icon1 = Icons.visibility;
                              } else {
                                icon1 = Icons.visibility_off;
                              }
                              setState(() {});
                            },
                          ),
                          validator: (value) {
                            return validateConfirmPassword(
                                value, password.text);
                          },
                        ),
                        SizedBox(
                          height: sizeConfig.screenHeight! * 0.02,
                        ),
                        CustomButton(
                            text: "Sign Up",
                            function: () {
                              if (formKey.currentState!.validate()) {
                                User user = User(
                                  email: email.text,
                                  image: "",
                                  name: name.text,
                                  password: password.text,
                                  phone: phone.text,
                                );
                                context.read<AuthBloc>().add(
                                      SignUpEvent(user: user),
                                    );
                              }
                            }),
                        SizedBox(
                          height: sizeConfig.screenHeight! * 0.02,
                        ),
                        const CustomLine(),
                        CustomActionRow(
                            text1: "Already have account",
                            text2: "login",
                            function: () {
                              pop(context);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
