import 'package:details_users_github/repositories/api.dart';
import 'package:details_users_github/models/repo_model.dart';
import 'package:details_users_github/pages/repo_details.dart';
import 'package:details_users_github/repositories/repo_github_repositorie.dart';
import 'package:details_users_github/repositories/user_repositorie.dart';
import 'package:details_users_github/services/util_services.dart';
import 'package:flutter/material.dart';
import 'package:details_users_github/config/app_data.dart' as app_data;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _userController = TextEditingController();
  UserRepositorie userRepositorie = UserRepositorie();
  RepoGithubRepositorie repoGithubRepositorie = RepoGithubRepositorie();
  Api api = Api();
  UtilServices utilServices = UtilServices();
  String user = 'Flutter';
  String userName = app_data.user.userName!;
  String? userbio = app_data.user.userbio!;
  String userUrl = app_data.user.userUrl!;

  _showDialogSearchUser() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            elevation: 6,
            contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
            title: const Text('Pesquisar Usuário'),
            content: TextFormField(
              cursorColor: Colors.white,
              autofocus: true,
              controller: _userController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.tealAccent,
                  ),
                ),
                label: const Text('UserName',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  fixedSize: const Size(100, 40),
                ),
                onPressed: () async {
                  var userApi = await api.getUser(_userController.text);
                  if (userApi != null) {
                    setState(() {
                      user = _userController.text;
                      userName = userApi['login'];
                      userbio = userApi['bio'];
                      userUrl = userApi['avatar_url'];
                    });
                  } else {
                    Navigator.of(context).pop();

                    setState(() {
                      utilServices.showToast(
                          msg: 'Usuário não encontrado', isError: true);
                    });
                  }
                },
                child: const Text(
                  'Pesquisar',
                  style: TextStyle(
                    color: Colors.tealAccent,
                    fontSize: 17,
                  ),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: _showDialogSearchUser, icon: const Icon(Icons.search))
        ],
        elevation: 0,
        title: Text(
          userName,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
              backgroundColor: Colors.tealAccent[400],
              child: CircleAvatar(
                radius: 53,
                backgroundImage: NetworkImage(userUrl),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                userbio == null ? 'Sem bio :(' : userbio.toString(),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<RepoUser>>(
                future: api.getRepoUser(user),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            List<RepoUser>? list = snapshot.data;
                            RepoUser repo = list![index];
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RepoDetails(
                                        repoUser: repo,
                                      ),
                                    ),
                                  );
                                },
                                title: Text(repo.nameRepo.toString()),
                              ),
                            );
                          })
                      : const Center(
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
