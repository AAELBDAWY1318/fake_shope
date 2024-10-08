import 'package:fake_shope_app/data/data_source/remote_data/products_repository.dart';
import 'package:fake_shope_app/data/models/product_model.dart';
import 'package:fake_shope_app/logic/product_bloc/product_bloc.dart';
import 'package:fake_shope_app/utils/constant/app_colors.dart';
import 'package:fake_shope_app/utils/functions/show_dialog.dart';
import 'package:fake_shope_app/utils/helpers/size.dart';
import 'package:fake_shope_app/utils/route_navigation/routes.dart';
import 'package:fake_shope_app/view/widgets/custom_button.dart';
import 'package:fake_shope_app/view/widgets/dynamic_text.dart';
import 'package:fake_shope_app/view/widgets/sparate_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int? maxLines = 5;
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocProvider(
        create: (context) => ProductBloc(ProductsRepository()),
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is AddToFavWaiting) {
              showLoadingDialog(context);
            } else if (state is AddToFavFailure) {
              pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is AddToFavSuccess) {
              pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            }

            if (state is AddToCartWaiting) {
              showLoadingDialog(context);
            } else if (state is AddToCartFailure) {
              pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is AddToCartSuccess) {
              pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizeConfig.screenWidth! * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.product.image,
                      width: double.infinity,
                      height: sizeConfig.screenHeight! * 0.25,
                      fit: BoxFit.contain,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: (sizeConfig.screenWidth! / 375) * 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(widget.product.inFavorites
                                ? Icons.favorite
                                : Icons.favorite_border),
                            onPressed: () {
                              context.read<ProductBloc>().add(
                                    AddToFavEvent(productId: widget.product.id),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("4.9"), Icon(Icons.star_half)],
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: (sizeConfig.screenWidth! / 375) * 20,
                      ),
                    ),
                    DynamicText(
                        maxLines: maxLines,
                        text: widget.product.description,
                        onTap: () {
                          if (maxLines != null) {
                            maxLines = null;
                          } else {
                            maxLines = 5;
                          }
                          setState(() {});
                        }),
                    SizedBox(
                      height: sizeConfig.screenHeight! * 0.05,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.grey[100],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Text(
                            "Quantity",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: (sizeConfig.screenWidth! / 375) * 20.0,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              counter++;
                              setState(() {});
                            },
                          ),
                          Text(
                            "$counter",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.remove,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              if (counter > 1) {
                                counter--;
                                setState(() {});
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: sizeConfig.screenHeight! * 0.01,
                    ),
                    const CustomLine(),
                    Row(
                      children: [
                        Text(
                          "${widget.product.price}",
                          style: TextStyle(
                            fontSize: (sizeConfig.screenHeight! / 375) * 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CustomButton(
                              function: () {
                                context.read<ProductBloc>().add(AddToCartEvent(
                                    productId: widget.product.id,
                                    quqntity: counter));
                              },
                              text: "Add To Cart",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
