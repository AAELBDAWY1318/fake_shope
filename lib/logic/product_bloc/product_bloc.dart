import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_shope_app/data/data_source/remote_data/products_repository.dart';
import 'package:fake_shope_app/data/models/product_model.dart';
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
      emit(const AddToFavFailure(message: "Error"));
    }
  }
}
