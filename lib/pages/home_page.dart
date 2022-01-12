import 'dart:convert';

import 'package:details_users_github/models/user_model.dart';
import 'package:details_users_github/pages/repo_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<RepoUser>> getRepoUser() async {
    http.Response response = await http.get(
      Uri.parse("https://api.github.com/users/flutter/repos"),
    );
    var repo = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(response.statusCode);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        elevation: 0,
        title: Text(
          'User Name',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.tealAccent[700],
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/images/programmer-computer-expert-black-linear-icon.jpg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                '😍 Apaixonado por tecnologia. 📱💻 Focado em desenvolvimento multiplataforma com Flutter. - Meetups🗣 😍.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<RepoUser>>(
                future: getRepoUser(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            List<RepoUser>? list = snapshot.data;
                            RepoUser repo = list![index];
                            return Expanded(
                              child: Card(
                                child: ListTile(
                                  onTap: () {
                                    if (repo.language != null &&
                                        repo.descriptionRepo != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RepoDetails(
                                              nameRepo: repo.nameRepo,
                                              descriptionRepo:
                                                  repo.descriptionRepo,
                                              createdAt: repo.createdAt,
                                              updatedAt: repo.updatedAt,
                                              urlRepo: repo.urlRepo,
                                              forksCount: repo.forksCount,
                                              starCount: repo.starCount,
                                              language: repo.language,
                                              topics: repo.topics),
                                        ),
                                      );
                                    }
                                  },
                                  title: Text(repo.nameRepo.toString()),
                                ),
                              ),
                            );
                          })
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
