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

class AddToFavWaiting extends ProductState{}

class AddToFavSuccess extends ProductState{
  final String message;

  const AddToFavSuccess({required this.message});

}

class AddToFavFailure extends ProductState{
  final String message;

  const AddToFavFailure({required this.message});
}
