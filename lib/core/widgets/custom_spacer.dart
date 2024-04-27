import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class customSpacer extends StatelessWidget {
  const customSpacer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        height: 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppConstants.whiteColor.withOpacity(0.5)),
        width: double.infinity,
      ),
    );
  }
}
