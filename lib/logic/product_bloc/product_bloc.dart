import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_shope_app/data/data_source/remote_data/products_repository.dart';
import 'package:fake_shope_app/data/models/product_model.dart';
import 'package:fake_shope_app/data/models/user_model.dart';
import 'package:fake_shope_app/utils/constant/app_text.dart';
import 'package:fake_shope_app/utils/constant/app_urls.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductsRepository productsRepository;
  ProductBloc(this.productsRepository) : super(ProductInitial()) {
    on<GetAllProductsEvent>(onGetAllProductsEvent);
    on<GetCategoryEvent>(getCategory);
    on<AddToFavEvent>(addToFav);
    on<GetFavEvent>(onGetFav);
    on<UpdateProfileEvent>(updateProfile);
    on<AddToCartEvent>(addToCart);
  }

  Future<void> onGetAllProductsEvent(
      GetAllProductsEvent event, Emitter emit) async {
    try {
      emit(GetAllProductsWaiting());
      Either<List<Product>, String> res =
          await productsRepository.getProducts(needUrl: AppUrl.getProducts);

      res.fold(
        (left) {
          emit(GetAllProductsSuccess(products: left));
        },
        (right) {
          emit(GetAllProductsFailure(message: right));
        },
      );
    } catch (e) {
      emit(const GetAllProductsFailure(message: AppText.unKnownError));
    }
  }

  Future<void> getCategory(GetCategoryEvent event, Emitter emit) async {
    try {
      emit(GetCategoryWaiting());
      Either<List<Product>, String> res =
          await productsRepository.getProducts(needUrl: event.url);

      res.fold(
        (left) {
          emit(GetCategorySuccess(products: left));
        },
        (right) {
          emit(GetAllProductsFailure(message: right));
        },
      );
    } catch (e) {
      emit(const GetAllProductsFailure(message: AppText.unKnownError));
    }
  }

  Future<void> addToFav(AddToFavEvent event, Emitter emit) async {
    try {
      emit(AddToFavWaiting());
      String res =
          await productsRepository.addToFav(productId: event.productId);
      if (res == "Success") {
        emit(const AddToFavSuccess(message: "Adding Success"));
      } else {
        emit(const AddToFavFailure(message: "Error"));
      }
    } catch (e) {
      log(e.toString());
      emit(const AddToFavFailure(message: "Error"));
    }
  }

  Future<void> addToCart(AddToCartEvent event, Emitter emit) async {
    try {
      emit(AddToFavWaiting());
      String res = await productsRepository.addToCart(
          productId: event.productId, quantity: event.quqntity);
      if (res == "Success") {
        emit(const AddToCartSuccess(message: "Adding Success"));
      } else {
        emit(const AddToCartFailure(message: "Error"));
      }
    } catch (e) {
      emit(const AddToCartFailure(message: "Error"));
    }
  }

  Future<void> onGetFav(GetFavEvent event, Emitter emit) async {
    try {
      emit(GetFavWaiting());
      var res = await productsRepository.getFavProducts();
      res.fold((left) {
        emit(GetFavSuccess(favList: left));
      }, (right) {
        emit(GetFavFailure(message: right));
      });
    } catch (e) {
      emit(const GetFavFailure(message: AppText.unKnownError));
    }
  }

  Future<void> updateProfile(UpdateProfileEvent event, Emitter emit) async {
    try {
      emit(UpdateProfileWaiting());
      var res = await productsRepository.updateProfile(event.user);
      res.fold((left) {
        emit(UpdateProfileSuccess(message: left));
      }, (right) {
        emit(UpdateProfileFailure(message: right));
      });
    } catch (e) {
      emit(const UpdateProfileFailure(message: AppText.unKnownError));
    }
  }
}
