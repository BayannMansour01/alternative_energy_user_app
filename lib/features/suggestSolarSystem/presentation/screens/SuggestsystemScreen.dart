import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/repo/suggestSystem_repo_impl.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/manager/cubit/suggest_system_cubit.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/screens/suggestpagebody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuggestsystemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'اقتراح منظومة',
          style: TextStyle(color: Colors.grey[200]),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            SuggestSystemCubit(getIt.get<SuggestSystemRepoImpl>()),
        child: DevicesList(),
      ),
    );
  }
}
