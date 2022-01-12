import 'package:details_users_github/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.grey[850],

      // Define the default font family.
      //fontFamily: 'Georgia',

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
        headline1: TextStyle(
            fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
        headline6: TextStyle(fontSize: 18.0, color: Colors.white),
        headline5: TextStyle(fontSize: 15.0, color: Colors.white),
        bodyText2: TextStyle(fontSize: 14.0),
      ),
    ),
    home: HomePage(),
  ));
}
