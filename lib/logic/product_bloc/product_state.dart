part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

class GetAllProductsWaiting extends ProductState {}

class GetAllProductsFailure extends ProductState {
  final String message;

  const GetAllProductsFailure({required this.message});
}

class GetAllProductsSuccess extends ProductState {
  final List<Product> products;

  const GetAllProductsSuccess({required this.products});
}

class GetCategoryWaiting extends ProductState {}

class GetCategoryFailure extends ProductState {
  final String message;

  const GetCategoryFailure({required this.message});
}

class GetCategorySuccess extends ProductState {
  final List<Product> products;

  const GetCategorySuccess({required this.products});
}

class AddToFavWaiting extends ProductState {}

class AddToFavSuccess extends ProductState {
  final String message;

  const AddToFavSuccess({required this.message});
}

class AddToFavFailure extends ProductState {
  final String message;

  const AddToFavFailure({required this.message});
}

class GetFavWaiting extends ProductState {}

class GetFavSuccess extends ProductState {
  final List<Map<String, dynamic>> favList;

  const GetFavSuccess({required this.favList});
}

class GetFavFailure extends ProductState {
  final String message;

  const GetFavFailure({required this.message});
}

class UpdateProfileWaiting extends ProductState {}

class UpdateProfileSuccess extends ProductState {
  final String message;

  const UpdateProfileSuccess({required this.message});
}

class UpdateProfileFailure extends ProductState {
  final String message;

  const UpdateProfileFailure({required this.message});
}

class AddToCartWaiting extends ProductState {}

class AddToCartSuccess extends ProductState {
  final String message;

  const AddToCartSuccess({required this.message});
}

class AddToCartFailure extends ProductState {
  final String message;

  const AddToCartFailure({required this.message});
}
