import 'package:fake_shope_app/data/data_source/remote_data/products_repository.dart';
import 'package:fake_shope_app/logic/product_bloc/product_bloc.dart';
import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:fake_shope_app/utils/constant/app_text.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:fake_shope_app/view/widgets/animated_error.dart';
import 'package:fake_shope_app/view/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CategoryScreen extends StatelessWidget {
  final String url;
  final String title;
  const CategoryScreen({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return BlocProvider(
      create: (context) => ProductBloc(ProductsRepository())
        ..add(
          GetCategoryEvent(url: url),
        ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            title,
          ),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is GetCategorySuccess) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: sizeConfig.screenWidth! * 0.05),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: sizeConfig.screenHeight! * 0.35,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return CustomCard(
                      image: state.products[index].image,
                      name: state.products[index].name,
                      onTap: () {},
                      price: "\$ ${state.products[index].price}",
                    );
                  },
                ),
              );
            } else if (state is GetCategoryFailure) {
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
