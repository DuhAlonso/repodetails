import 'package:details_users_github/pages/home_controller.dart';
import 'package:details_users_github/pages/widgets/repositorie_counts_widget.dart';
import 'package:details_users_github/pages/widgets/topics_lists_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final controller = HomeController();

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
                  RepositorieCountsWidget(
                      count: widget.repoUser.starCount!,
                      icon: Icons.star,
                      text: 'Star',
                      context: context),
                  const SizedBox(width: 20),
                  RepositorieCountsWidget(
                      count: widget.repoUser.forksCount!,
                      icon: Icons.get_app_outlined,
                      text: 'Fork',
                      context: context),
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
                  trailing: controller.formatDate(widget.repoUser.createdAt!)),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                  title: const Text(
                    'Última Atualização',
                  ),
                  trailing: controller.formatDate(widget.repoUser.updatedAt!)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Tópico(s)',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            TopicsListsWidget(topics: topics, language: language),
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
