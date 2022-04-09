import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtilServices {
  void showToast({required String msg, bool isError = false}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor:
            !isError ? const Color(0xFFffffff) : const Color(0xFFff0000),
        textColor: isError ? const Color(0xFFffffff) : const Color(0xFF000000));
  }
}
