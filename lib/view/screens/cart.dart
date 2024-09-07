import 'dart:developer';

import 'package:fake_shope_app/data/data_source/remote_data/products_repository.dart';
import 'package:fake_shope_app/logic/product_bloc/product_bloc.dart';
import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:fake_shope_app/utils/constant/app_text.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:fake_shope_app/utils/route_navigation/routes.dart';
import 'package:fake_shope_app/view/screens/product_details.dart';
import 'package:fake_shope_app/view/widgets/animated_error.dart';
import 'package:fake_shope_app/view/widgets/cart_item.dart';
import 'package:fake_shope_app/view/widgets/sparate_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late double total;
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return BlocProvider(
      create: (context) => ProductBloc(ProductsRepository())
        ..add(
          GetCartsEvent(),
        ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          foregroundColor: Colors.black,
          title: const Text("Shopping Cart"),
          centerTitle: true,
        ),
        floatingActionButton: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Payment ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          ),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is GetCartsSuccess) {
              total = 0.0;
              for (int i = 0; i < state.cartsList.length; i++) {
                total += state.cartsList[0]["product"].price;
              }
              log("$total");
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizeConfig.screenWidth! * 0.05),
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: CustomLine(),
                        ),
                        itemCount: state.cartsList.length,
                        itemBuilder: (context, index) {
                          return CartItem(
                            image: state.cartsList[index]["product"].image,
                            name: state.cartsList[index]["product"].name,
                            price: state.cartsList[index]["product"].price,
                            onTap: () {
                              push(context,
                                  page: ProductDetails(
                                      product: state.cartsList[index]
                                          ["product"]));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is GetCartsFailure) {
              if (state.message == AppText.empty) {
                return AnimatedError(
                    repeat: false,
                    text: state.message,
                    asset: "assets/lotties/empty.json");
              } else if (state.message == AppText.serverError) {
                return AnimatedError(
                    repeat: false,
                    text: state.message,
                    asset: "assets/lotties/server.json");
              } else {
                return AnimatedError(
                    repeat: false,
                    text: state.message,
                    asset: "assets/lotties/internet.json");
              }
            } else {
              return Center(
                child: LoadingAnimationWidget.dotsTriangle(
                    color: AppColors.primaryColor, size: 50.0),
              );
            }
          },
        ),
      ),
    );
  }
}
