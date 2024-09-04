import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name, description, image;
  final int id;
  final double price, oldPrice, discount;
  final bool inFavorites, inCart;
  final List images;
  const Product({
    required this.name,
    required this.description,
    required this.id,
    required this.price,
    required this.discount,
    required this.oldPrice,
    required this.inFavorites,
    required this.inCart,
    required this.images,
    required this.image,
  });

  static Product fromJson({required Map<String, dynamic> json}) {
    return Product(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      price: (json["price"] as num).toDouble(),
      discount: (json["discount"] as num).toDouble(),
      inCart: json["in_cart"] ?? false,
      images: json["images"] ?? [],
      inFavorites: json["in_favorites"] ?? false,
      oldPrice: (json["old_price"] as num).toDouble(),
      image: json["image"],
    );
  }

  @override
  List<Object?> get props => [
        name,
        id,
        image,
        description,
        price,
        discount,
        inCart,
        inFavorites,
        images,
        oldPrice
      ];
}
