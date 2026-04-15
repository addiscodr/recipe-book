import 'package:recipe_book/models/user.dart';
import 'package:recipe_book/services/http_service.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();

  factory AuthService() {
    return _singleton;
  }

  final _httpService = HttpService();

  User? user;

  AuthService._internal();

  Future<bool> login(String email, String password) async {
    try {
      final response = await _httpService.post("auth/login", {
        "email": email,
        "password": password,
      });

      if (response != null &&
          response.statusCode == 200 &&
          response.data != null) {
        user = User.fromJson(response.data);
        HttpService().setup(
          bearerToken: user!.accessToken.isNotEmpty ? user!.accessToken : null,
        );
        return true;
      }
    } catch (e) {
      print("Login Error: $e");
    }

    return false;
  }

  Future<bool> signup(String email, String password) async {
    try {
      final response = await _httpService.post("auth/signup", {
        "email": email,
        "password": password,
      });

      if (response != null &&
          response.statusCode == 200 &&
          response.data != null) {
        user = User.fromJson(response.data);
        HttpService().setup(
          bearerToken: user!.accessToken.isNotEmpty ? user!.accessToken : null,
        );
        return true;
      }
    } catch (e) {
      print("Signup Error: $e");
    }

    return false;
  }
}
