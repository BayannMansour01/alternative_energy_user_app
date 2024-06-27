import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class CustomProgressIndicator {
  static bool isOpen = false;
  static void showProgressIndicator(BuildContext context) {
    isOpen = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.grey.withOpacity(.3),
      builder: (context) => WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Center(
          child: CircularProgressIndicator(
            color: AppConstants.blueColor,
            strokeWidth: 3,
          ),
        ),
      ),
    ).then((value) => isOpen = false);
  }
}
