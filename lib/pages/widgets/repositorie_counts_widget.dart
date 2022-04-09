import 'package:flutter/material.dart';

class RepositorieCountsWidget extends StatelessWidget {
  int count;
  IconData icon;
  String text;
  BuildContext context;

  RepositorieCountsWidget(
      {required int this.count,
      required IconData this.icon,
      required String this.text,
      required BuildContext this.context,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
