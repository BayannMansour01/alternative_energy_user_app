import 'dart:developer';

import 'package:alternative_energy_user_app/core/widgets/custom_button.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/manager/cubit/suggest_system_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuggestSystem extends StatelessWidget {
  const SuggestSystem({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SuggestSystemCubit>(context);
    return Scaffold(
      body: Center(
        child: CustomButton(
          text: 'test',
          onTap: () {
            Map<String, dynamic> test = cubit.suggestSystem(cubit.userDevices);
            log(test.toString());

            // int batteryNum = (test["Aha"] / 200).round() *
            //     (test["SystemVoltage"] / 12).round();
            // int panelsNum = (test['PV'] / 500).round();

            // log(batteryNum.toString());
            // log(panelsNum.toString());
          },
        ),
      ),
    );
  }
}
