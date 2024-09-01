import 'dart:convert';
import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:fake_shope_app/data/models/product_model.dart';
import 'package:fake_shope_app/utils/constant/app_text.dart';
import 'package:fake_shope_app/utils/constant/app_urls.dart';
import 'package:fake_shope_app/utils/functions/check_connection.dart';
import 'package:fake_shope_app/utils/helpers/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ProductsRepository {
  Future<Either<List<Product>, String>> getProducts(
      {required String needUrl}) async {
    if (await checkConnection()) {
      try {
        var url = Uri.parse("${AppUrl.baseUrl}$needUrl");
        Response response = await http.get(url);
        if (response.statusCode >= 200 && response.statusCode <= 202) {
          var body = json.decode(response.body);
          if (body["status"]) {
            List data = body["data"]["data"];
            // log("$data");
            if (data.isEmpty) {
              return const Right(AppText.empty);
            } else {
              List<Product> products = [];
              for (int i = 0; i < data.length; i++) {
                products.add(Product.fromJson(json: data[i]));
              }
              return Left(products);
            }
          } else {
            return const Right(AppText.serverError);
          }
        } else {
          return const Right(AppText.serverError);
        }
      } catch (e) {
        log(e.toString());
        return const Right(AppText.unKnownError);
      }
    } else {
      return const Right(AppText.internetError);
    }
  }

  Future<String> addToFav({required int productId}) async {
    if (await checkConnection()) {
      try {
        String? token = await SharedPreferencesHelper().getToken();
        if (token != null) {
          final headers = {
            'lang': 'ar',
            'Content-Type': 'application/json',
            'Authorization': token,
          };
          final body = jsonEncode({
            'product_id': productId,
          });
          var url = Uri.parse("${AppUrl.baseUrl}${AppUrl.favorites}");
          Response response =
              await http.post(url, body: body, headers: headers);

          if (response.statusCode >= 200 && response.statusCode <= 202) {
            final responseData = jsonDecode(response.body);
            if (responseData['status']) {
              return "Success";
            } else {
              return "Error";
            }
          } else {
            return "Error";
          }
        } else {
          return "Error";
        }
      } catch (e) {
        return "Error";
      }
    } else {
      return "Error";
    }
  }

  Future<String> deteteFromFav({required int id}) async {
    if (await checkConnection()) {
      try {
        String? token = await SharedPreferencesHelper().getToken();
        if (token != null) {
          final headers = {
            'lang': 'ar',
            'Content-Type': 'application/json',
            'Authorization': token,
          };
          var url = Uri.parse("${AppUrl.baseUrl}${AppUrl.favorites}/$id");
          Response response =
              await http.delete(url, headers: headers);

          if (response.statusCode >= 200 && response.statusCode <= 202) {
            final responseData = jsonDecode(response.body);
            if (responseData['status']) {
              return "Success";
            } else {
              return "Error";
            }
          } else {
            return "Error";
          }
        } else {
          return "Error";
        }
      } catch (e) {
        return "Error";
      }
    } else {
      return "Error";
    }
  }
}
