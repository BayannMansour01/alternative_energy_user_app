import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/manager/cubit/suggest_system_cubit.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/screens/suggestpagebody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 class SuggestsystemScreen extends StatelessWidget{

 
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: AppConstants.orangeColor,
    appBar: AppBar(
        title: Text(
          'اقتراح منظومة',
          style: TextStyle(color: Colors.white),
        ),
      ),
    body: BlocProvider(
      create: (context) => SuggestSystemCubit(),
      child: MyCustomWidget(),
     ),
   );
  }

}