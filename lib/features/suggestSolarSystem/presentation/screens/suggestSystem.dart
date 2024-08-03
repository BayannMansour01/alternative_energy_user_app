import 'dart:developer';

import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/core/widgets/custom_button.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/repos/previous_jobs_repo_impl.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/repo/suggestSystem_repo_impl.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/manager/cubit/suggest_system_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuggestSystem extends StatelessWidget {
  const SuggestSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SuggestSystemCubit(getIt.get<SuggestSystemRepoImpl>()),
      child: BlocConsumer<SuggestSystemCubit, SuggestSystemState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = BlocProvider.of<SuggestSystemCubit>(context);
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CustomButton(
                    text: 'test',
                    onTap: () {
                      // Map<String, dynamic> test =
                      //     cubit.suggestSystem(cubit.userDevices);
                      // log(test.toString());
                      cubit.fetchAllDevices();

                      // int batteryNum = (test["Aha"] / 200).round() *
                      //     (test["SystemVoltage"] / 12).round();
                      // int panelsNum = (test['PV'] / 500).round();

                      // log(batteryNum.toString());
                      // log(panelsNum.toString());
                      log("cubbbbbbbb${cubit.devicesFromServer[0].maxCurrent}");
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: 'Change',
                  onTap: () {
                    // Map<String, dynamic> test =
                    //     cubit.suggestSystem(cubit.userDevices);
                    // log(test.toString());
                    cubit.changeDeviceWatt(2000, 2);

                    // int batteryNum = (test["Aha"] / 200).round() *
                    //     (test["SystemVoltage"] / 12).round();
                    // int panelsNum = (test['PV'] / 500).round();

                    // log(batteryNum.toString());
                    // log(panelsNum.toString());
                    log("change${cubit.devicesFromServer[0].maxCurrent}");
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: 'selectDevices',
                  onTap: () {
                    cubit.changeDeviceWatt(2000, 2);
                    log("change${cubit.devicesFromServer[0].maxCurrent}");
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
