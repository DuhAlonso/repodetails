import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/repo_model.dart';

class RepoGithubRepositorie {
  Future<List<RepoUser>> getRepoUser(String user) async {
    http.Response response = await http.get(
      Uri.parse("https://api.github.com/users/$user/repos"),
    );
    var repo = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<RepoUser> repos = [];

      for (var rep in repo) {
        RepoUser r = RepoUser(
          nameRepo: rep['name'],
          descriptionRepo: rep['description'],
          createdAt: rep['created_at'],
          updatedAt: rep['updated_at'],
          urlRepo: rep['svn_url'],
          forksCount: rep['forks_count'],
          starCount: rep['stargazers_count'],
          language: rep['language'],
          topics: rep['topics'],
        );
        repos.add(r);
      }
      return repos;
    } else {
      throw Exception("Failed to load");
    }
  }
}
