part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetAllProductsEvent extends ProductEvent {}

class GetCategoryEvent extends ProductEvent {
  final String url;

  const GetCategoryEvent({required this.url});
}

class AddToFavEvent extends ProductEvent{
  final int productId;

  const AddToFavEvent({required this.productId});
}

class GetFavEvent extends ProductEvent{}

class UpdateProfileEvent extends ProductEvent{
  final User user;

  const UpdateProfileEvent({required this.user});
}

