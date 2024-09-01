import 'package:fake_shope_app/data/data_source/remote_data/auth_repository.dart';
import 'package:fake_shope_app/logic/auth_bloc/auth_bloc.dart';
import 'package:fake_shope_app/utils/functions/email_validation.dart';
import 'package:fake_shope_app/utils/functions/password_validation.dart';
import 'package:fake_shope_app/utils/functions/show_dialog.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:fake_shope_app/utils/route_navigation/routes.dart';
import 'package:fake_shope_app/view/screens/auth/signup/signup.dart';
import 'package:fake_shope_app/view/layouts/app_layouts.dart';
import 'package:fake_shope_app/view/widgets/action_row.dart';
import 'package:fake_shope_app/view/widgets/custom_button.dart';
import 'package:fake_shope_app/view/widgets/custom_text.dart';
import 'package:fake_shope_app/view/widgets/sparate_line.dart';
import 'package:fake_shope_app/view/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  IconData icon = Icons.visibility_off;
  bool obscureText = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return BlocProvider(
      create: (context) => AuthBloc(AuthRepository()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginWaiting) {
            showLoadingDialog(context);
          } else if (state is LoginSuccess) {
            pop(context);
            pushAndRemoveAll(context, page: const AppLayout());
          } else if (state is LoginFailure) {
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
                        Center(
                          child: Image.asset(
                            "assets/images/logoo.png",
                            width: sizeConfig.screenWidth! * 0.5,
                            height: sizeConfig.screenHeight! * 0.3,
                          ),
                        ),
                        const CustomText(text: "LOGIN TO YOUR \nACCOUNT"),
                        SizedBox(
                          height: sizeConfig.screenHeight! * 0.02,
                        ),
                        CustomTextForm(
                          hintText: "Email",
                          controller: emailController,
                          validator: validateEmail,
                        ),
                        SizedBox(
                          height: sizeConfig.screenHeight! * 0.02,
                        ),
                        CustomTextForm(
                          hintText: "Password",
                          controller: passwordController,
                          validator: validatePassword,
                          suffixIcon: IconButton(
                            icon: Icon(icon),
                            onPressed: () {
                              obscureText = !obscureText;
                              if (icon == Icons.visibility_off) {
                                icon = Icons.visibility;
                              } else {
                                icon = Icons.visibility_off;
                              }
                              setState(() {});
                            },
                          ),
                          obscureText: obscureText,
                        ),
                        SizedBox(
                          height: sizeConfig.screenHeight! * 0.02,
                        ),
                        CustomButton(
                            text: "Login",
                            function: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      LoginEvent(
                                          email: emailController.text,
                                          password: passwordController.text),
                                    );
                              }
                            }),
                        const CustomLine(),
                        CustomActionRow(
                            text1: "Don't have account",
                            text2: "Sign up",
                            function: () {
                              push(context, page: const SignUpScreen());
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
