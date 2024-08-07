import 'package:alternative_energy_user_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';

abstract class CustomSnackBar {
  static void showCustomSnackBar(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: SizeConfig.defaultSize * 2),
        ),
        backgroundColor:
            backgroundColor?.withOpacity(.9) ?? Colors.green.withOpacity(.9),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
        margin: EdgeInsets.only(
          bottom:
              SizeConfig.defaultSize * 10, // Adjusted margin to fit on screen
          left: 5,
          right: 5,
        ),
      ),
    );
  }

  static void showErrorSnackBar(
    BuildContext context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom:
              SizeConfig.defaultSize * 10, // Adjusted margin to fit on screen
          left: 10,
          right: 10,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              ),
            ),
            Center(
              child: Text(
                message,
                style: TextStyle(fontSize: SizeConfig.defaultSize * 2),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 30),
      ),
    );
  }
}
