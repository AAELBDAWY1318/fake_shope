import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String name;
  final String password;
  final String image;
  final String phone;

  const User(
      {required this.email,
      required this.name,
      required this.password,
      required this.image,
      required this.phone});

  // create empty obj.
  static User empty =
      const User(email: "", name: "", password: "", image: "", phone: "");

  //test if the user is empty
  bool get isEmpty => this == empty;

  // convert to json
  Map<String, String> toJson() {
    return {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
      "image":
          "https://cdn2.iconfinder.com/data/icons/people-pack-04/512/icon-pro_984-512.png"
    };
  }

  static User fromJson({required Map json}) {
    return User(
      email: json["email"],
      image: json["image"],
      name: json["name"],
      password: json["password"],
      phone: json["phone"],
    );
  }

  @override
  List<Object?> get props => [email, name, password, image, phone];
}
