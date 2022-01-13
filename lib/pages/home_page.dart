import 'package:details_users_github/controller/api.dart';
import 'package:details_users_github/models/repo_model.dart';
import 'package:details_users_github/pages/repo_details.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _userController = TextEditingController();
  Api api = Api();
  String user = 'Flutter';
  String? userName = 'Flutter';
  String? userbio =
      'Flutter is Googles UI toolkit for building beautiful, natively compiled applications for mobile, web, desktop, and embedded devices from a single codebase.';
  String? userUrl = 'https://avatars.githubusercontent.com/u/14101776?v=4';

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
                label: const Text('Nome do User',
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
                  print(userApi);
                  setState(() {
                    user = _userController.text;
                    userName = userApi['login'];
                    userbio = userApi['bio'];
                    userUrl = userApi['avatar_url'];
                  });
                  Navigator.pop(context);
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
          userName == null ? 'User Name' : userName.toString(),
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
                backgroundImage: NetworkImage(userUrl!),
                // NetworkImage(
                //   'https://avatars.githubusercontent.com/u/53386801?v=4')
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
                                  if (repo.language != null) {
                                    repo.descriptionRepo == null
                                        ? ''
                                        : Navigator.push(
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
