import 'package:flutter/material.dart';

class TopicsListsWidget extends StatelessWidget {
  List topics;
  String language;
  TopicsListsWidget({
    Key? key,
    required this.topics,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
