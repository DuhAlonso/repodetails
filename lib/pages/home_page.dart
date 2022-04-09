import 'package:details_users_github/pages/home_controller.dart';
import 'package:details_users_github/models/repo_model.dart';
import 'package:details_users_github/pages/repo_details.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Colors.grey[850],
            appBar: AppBar(
              backgroundColor: Colors.grey[850],
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () async {
                      await controller.showDialogSearchUser(context: context);
                    },
                    icon: const Icon(Icons.search))
              ],
              elevation: 0,
              title: Text(
                controller.userName,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                      backgroundImage: NetworkImage(controller.userUrl),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      controller.userbio == null
                          ? 'Sem bio :('
                          : controller.userbio.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<RepoUser>>(
                      future: controller.getRepoUser(),
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
        });
  }
}
