import 'package:fake_shope_app/data/data_source/remote_data/products_repository.dart';
import 'package:fake_shope_app/data/data_source/static/banners_data.dart';
import 'package:fake_shope_app/logic/product_bloc/product_bloc.dart';
import 'package:fake_shope_app/utils/constant/app_text.dart';
import 'package:fake_shope_app/utils/constant/app_urls.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:fake_shope_app/utils/route_navigation/routes.dart';
import 'package:fake_shope_app/view/screens/category_screen.dart';
import 'package:fake_shope_app/view/screens/product_details.dart';
import 'package:fake_shope_app/view/widgets/animated_error.dart';
import 'package:fake_shope_app/view/widgets/banner_item.dart';
import 'package:fake_shope_app/view/widgets/custom_card.dart';
import 'package:fake_shope_app/view/widgets/custom_icon_button.dart';
import 'package:fake_shope_app/view/widgets/custom_search_form.dart';
import 'package:fake_shope_app/view/widgets/home_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return BlocProvider(
      create: (context) => ProductBloc(ProductsRepository())
        ..add(
          GetAllProductsEvent(),
        ),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is GetAllProductsSuccess) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: sizeConfig.screenWidth! * 0.05),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomSearchForm(onTap: () {}),
                      SizedBox(
                        height: sizeConfig.screenHeight! * 0.03,
                      ),
                      const Text("Welcome \nlet get your shopping"),
                      SizedBox(
                        height: sizeConfig.screenHeight! * 0.02,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            BannerItem(image: banners[0]),
                            SizedBox(
                              width: sizeConfig.screenWidth! * 0.03,
                            ),
                            BannerItem(image: banners[1]),
                            SizedBox(
                              width: sizeConfig.screenWidth! * 0.03,
                            ),
                            BannerItem(image: banners[2]),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: sizeConfig.screenHeight! * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // electonics
                          CustomIconButton(
                              fontAwesomeIcons: FontAwesomeIcons.laptop,
                              function: () {
                                push(context,
                                    page: const CategoryScreen(
                                      url: AppUrl.getElectricCategory,
                                      title: "Electronics",
                                    ));
                              }),
                          //clothes
                          CustomIconButton(
                              fontAwesomeIcons: FontAwesomeIcons.shirt,
                              function: () {
                                push(context,
                                    page: const CategoryScreen(
                                        url: AppUrl.getClothesCategory,
                                        title: "Clothes"));
                              }),
                          //sports
                          CustomIconButton(
                              fontAwesomeIcons: FontAwesomeIcons.football,
                              function: () {
                                push(context,
                                    page: const CategoryScreen(
                                        url: AppUrl.getSportCategory,
                                        title: "Sports"));
                              }),
                          // lamb
                          CustomIconButton(
                              fontAwesomeIcons: FontAwesomeIcons.lightbulb,
                              function: () {
                                push(context,
                                    page: const CategoryScreen(
                                        url: AppUrl.getLightCategory,
                                        title: "Light Tools"));
                              }),
                        ],
                      ),
                      SizedBox(
                        height: sizeConfig.screenHeight! * 0.02,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: sizeConfig.screenHeight! * 0.35,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                            image: state.products[index].image,
                            name: state.products[index].name,
                            onTap: () {
                              push(context,
                                  page: ProductDetails(
                                      product: state.products[index]));
                            },
                            price: "\$ ${state.products[index].price}",
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is GetAllProductsFailure) {
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
            return const HomeLoading();
          }
        },
      ),
    );
  }
}
