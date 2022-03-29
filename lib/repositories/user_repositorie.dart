import 'dart:convert';
import 'package:details_users_github/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepositorie {
  Future<UserModel> getUser(String user) async {
    http.Response response = await http.get(
      Uri.parse("https://api.github.com/users/$user"),
    );
    //var userResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.body);
    } else {
      throw Exception();
    }
  }
}
