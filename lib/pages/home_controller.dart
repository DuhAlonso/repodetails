import 'package:details_users_github/models/repo_model.dart';
import 'package:details_users_github/repositories/repo_github_repositorie.dart';
import 'package:details_users_github/repositories/user_repositorie.dart';
import 'package:details_users_github/services/util_services.dart';
import 'package:flutter/material.dart';
import 'package:details_users_github/config/app_data.dart' as app_data;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HomeController extends ChangeNotifier {
  final TextEditingController _userController = TextEditingController();
  final UserRepositorie _userRepositorie = UserRepositorie();
  final RepoGithubRepositorie _repoGithubRepositorie = RepoGithubRepositorie();
  UtilServices utilServices = UtilServices();
  String user = 'Flutter';
  String userName = app_data.user.userName!;
  String? userbio = app_data.user.userbio!;
  String userUrl = app_data.user.userUrl!;

  Future<void> showDialogSearchUser({required BuildContext context}) async {
    await showDialog(
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
                var userModel =
                    await _userRepositorie.getUser(_userController.text);
                if (userModel != null) {
                  user = _userController.text;
                  userName = userModel['login'];
                  userbio = userModel['bio'];
                  userUrl = userModel['avatar_url'];
                  notifyListeners();
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                  utilServices.showToast(
                      msg: 'Usuário não encontrado', isError: true);
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
      },
    );
  }

  Future<List<RepoUser>> getRepoUser() async {
    var repos;
    return repos = await _repoGithubRepositorie.getRepoUser(user);
  }

  formatDate(String date) {
    initializeDateFormatting('pt_BR');
    var formatter = DateFormat.yMMMd('pt_BR'); // formata no padrão Brasileiro
    DateTime dateConverted = DateTime.parse(date);
    String formattedDate = formatter.format(dateConverted);
    return Text(
      formattedDate,
      textAlign: TextAlign.start,
      style: const TextStyle(fontSize: 15),
    );
  }
}
