import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:details_users_github/models/repo_model.dart';

// ignore: must_be_immutable
class RepoDetails extends StatefulWidget {
  RepoUser repoUser;

  RepoDetails({
    Key? key,
    required this.repoUser,
  }) : super(key: key);

  @override
  _RepoDetailsState createState() => _RepoDetailsState();
}

class _RepoDetailsState extends State<RepoDetails> {
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

  @override
  Widget build(BuildContext context) {
    String language = widget.repoUser.language ?? 'github';
    List topics = widget.repoUser.topics ?? ['GitHub'];

    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[850],
        title: Text(widget.repoUser.nameRepo!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              widget.repoUser.descriptionRepo ?? 'Repositorie the GitHub',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  repoCount(
                      widget.repoUser.starCount!, Icons.star, 'Star', context),
                  const SizedBox(width: 20),
                  repoCount(widget.repoUser.forksCount!, Icons.get_app_outlined,
                      'Fork', context)
                ],
              ),
            ),
            Text(
              'Linguagem predominante no projeto',
              style: Theme.of(context).textTheme.headline6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.network(
                    'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/${language.toLowerCase()}/${language.toLowerCase()}-original.svg',
                    height: 80,
                    placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(30.0),
                        child: const CircularProgressIndicator()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      language,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                  title: const Text(
                    'Criação do Repositório',
                  ),
                  trailing: formatDate(widget.repoUser.createdAt!)),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                  title: const Text(
                    'Última Atualização',
                  ),
                  trailing: formatDate(widget.repoUser.updatedAt!)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Tópicos',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            topicsList(topics, language),
            const Flexible(
              fit: FlexFit.tight,
              child: SizedBox(height: 10),
            ),
            GestureDetector(
              onTap: () {
                launch(widget.repoUser.urlRepo!);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(widget.repoUser.urlRepo!),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget repoCount(int count, IconData icon, String text, BuildContext context) {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
    decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.white),
        borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.headline6,
        )
      ],
    ),
  );
}

Widget topicsList(List topics, String language) {
  topics.isEmpty ? topics.add(language) : topics;
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List<Widget>.generate(
        topics.length,
        (int idx) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Chip(
              labelPadding: const EdgeInsets.all(2.0),
              label: Text(
                topics[idx],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.grey[750],
              elevation: 6.0,
              shadowColor: Colors.grey[60],
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            ),
          );
        },
      ).toList(),
    ),
  );
}
