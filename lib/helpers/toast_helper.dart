import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_search/constants/color_constants.dart';

class ToastHelper {
  ToastHelper._internal();

  static void showErrorToast(BuildContext context, message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorConstants.error,
        textColor: Colors.white,
        fontSize: Theme.of(context).textTheme.bodySmall?.fontSize ?? 16);
  }

  static void showSuccessToast(BuildContext context, message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorConstants.success,
        textColor: Colors.white,
        fontSize: Theme.of(context).textTheme.bodySmall?.fontSize ?? 16);
  }
}
