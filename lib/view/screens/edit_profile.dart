import 'package:fake_shope_app/data/data_source/remote_data/products_repository.dart';
import 'package:fake_shope_app/data/models/user_model.dart';
import 'package:fake_shope_app/logic/product_bloc/product_bloc.dart';
import 'package:fake_shope_app/utils/functions/email_validation.dart';
import 'package:fake_shope_app/utils/functions/phone_validation.dart';
import 'package:fake_shope_app/utils/functions/show_dialog.dart';
import 'package:fake_shope_app/utils/functions/username_validation.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:fake_shope_app/utils/route_navigation/routes.dart';
import 'package:fake_shope_app/view/widgets/custom_button.dart';
import 'package:fake_shope_app/view/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    email.text = widget.user.email;
    name.text = widget.user.name;
    phone.text = widget.user.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return BlocProvider(
      create: (context) => ProductBloc(ProductsRepository()),
      child: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is UpdateProfileWaiting) {
            showLoadingDialog(context);
          } else if (state is UpdateProfileFailure) {
            pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          } else if (state is UpdateProfileSuccess) {
            pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0.0,
              title: const Text("Edit Profile"),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizeConfig.screenWidth! * 0.05),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
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
                            widget.user.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sizeConfig.screenHeight! * 0.03,
                      ),
                      CustomTextForm(
                        controller: name,
                        hintText: "Name",
                        validator: validateUsername,
                      ),
                      SizedBox(
                        height: sizeConfig.screenHeight! * 0.03,
                      ),
                      CustomTextForm(
                        controller: email,
                        hintText: "Email",
                        validator: validateEmail,
                      ),
                      SizedBox(
                        height: sizeConfig.screenHeight! * 0.03,
                      ),
                      CustomTextForm(
                        controller: phone,
                        hintText: "Phone",
                        validator: validateEgyptianPhoneNumber,
                      ),
                      SizedBox(
                        height: sizeConfig.screenHeight! * 0.03,
                      ),
                      CustomButton(
                          text: "Save Changes",
                          function: () {
                            if (formKey.currentState!.validate()) {
                              User userTemp = User(
                                email: email.text,
                                image: widget.user.image,
                                name: name.text,
                                password: widget.user.password,
                                phone: phone.text,
                              );
                              context.read<ProductBloc>().add(
                                    UpdateProfileEvent(user: userTemp),
                                  );
                            }
                          }),
                    ],
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
