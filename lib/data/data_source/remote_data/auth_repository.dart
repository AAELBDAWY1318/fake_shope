import 'dart:convert';
import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:fake_shope_app/data/models/user_model.dart';
import 'package:fake_shope_app/utils/constant/app_text.dart';
import 'package:fake_shope_app/utils/constant/app_urls.dart';
import 'package:fake_shope_app/utils/functions/check_connection.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthRepository {
  Future<Either<String, String>> signup({required User user}) async {
    if (await checkConnection()) {
      try {
        var url = Uri.parse("${AppUrl.baseUrl}${AppUrl.signup}");
        Response response = await http.post(url, body: user.toJson());
        if (response.statusCode >= 200 && response.statusCode <= 202) {
          var data = json.decode(response.body);
          if (data["status"]) {
            return Left(data["data"]["token"]);
          } else {
            return const Right(AppText.emailExist);
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

  Future<Either<String, String>> login(
      {required String email, required String password}) async {
    if (await checkConnection()) {
      try {
        var url = Uri.parse("${AppUrl.baseUrl}${AppUrl.login}");
        Response response =
            await http.post(url, body: {"email": email, "password": password});
        if (response.statusCode >= 200 && response.statusCode <= 202) {
          var data = json.decode(response.body);
          if (data["status"]) {
            return Left(data["data"]["token"]);
          } else {
            return const Right(AppText.wrongEmail);
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
}
