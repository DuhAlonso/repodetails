import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class RepoDetails extends StatefulWidget {
  String? nameRepo;
  String? descriptionRepo;
  String? createdAt;
  String? updatedAt;
  String? urlRepo;
  int? forksCount;
  int? starCount;
  String? language;
  List? topics;

  RepoDetails({
    this.nameRepo,
    this.descriptionRepo,
    this.createdAt,
    this.updatedAt,
    this.urlRepo,
    this.forksCount,
    this.starCount,
    this.language,
    this.topics,
  });

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
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[850],
        title: Text(widget.nameRepo!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              widget.descriptionRepo!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  repoCount(widget.starCount!, Icons.star, 'Star', context),
                  SizedBox(width: 20),
                  repoCount(widget.forksCount!, Icons.get_app_outlined, 'Fork',
                      context)
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
                    'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/${widget.language!.toLowerCase()}/${widget.language!.toLowerCase()}-original.svg',
                    placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(30.0),
                        child: const CircularProgressIndicator()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      widget.language!,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                  title: Text(
                    'Criação do Repositório',
                  ),
                  trailing: formatDate(widget.createdAt!)),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                  title: Text(
                    'Última Atualização',
                  ),
                  trailing: formatDate(widget.updatedAt!)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Tópicos',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            topicsList(widget.topics!),
          ],
        ),
      ),
    );
  }
}

Widget repoCount(int count, IconData icon, String text, BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
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

Widget topicsList(List topics) {
  return Wrap(
    alignment: WrapAlignment.center,
    spacing: 3.0,
    runSpacing: 1.0,
    children: List<Widget>.generate(
      topics.length,
      (int idx) {
        return Chip(
          labelPadding: EdgeInsets.all(2.0),
          label: Text(
            topics[idx],
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.grey[750],
          elevation: 6.0,
          shadowColor: Colors.grey[60],
          padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
        );
      },
    ).toList(),
  );
}
