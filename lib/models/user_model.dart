import 'dart:convert';

class UserModel {
  String? userName;
  String? userbio;
  String? userUrl;
  UserModel({
    this.userName,
    this.userbio,
    this.userUrl,
  });

  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     userName: json['login'],
  //     userUrl: json['avatar_url'],
  //     userbio: json['bio'],
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userbio': userbio,
      'userUrl': userUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'],
      userbio: map['userbio'],
      userUrl: map['userUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserModel(userName: $userName, userbio: $userbio, userUrl: $userUrl)';
}
