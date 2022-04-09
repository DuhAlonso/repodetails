import 'dart:convert';

import 'package:http/http.dart' as http;

class UserRepositorie {
  Future getUser(String user) async {
    http.Response response = await http.get(
      Uri.parse("https://api.github.com/users/$user"),
    );
    //var userResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      //userModel = UserModel.fromJson(response.body);
      var userResponse = jsonDecode(response.body);
      return userResponse;
    } else {
      return null;
    }
  }
}
