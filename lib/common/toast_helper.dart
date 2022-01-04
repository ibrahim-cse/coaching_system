import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

MyAlertDialog(BuildContext context, String mymsg) {
  Fluttertoast.showToast(
    msg: mymsg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}


