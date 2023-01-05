import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
  );
}

extension printX on String {
  void printLog() {
    debugPrint("====> $this");
  }
}
