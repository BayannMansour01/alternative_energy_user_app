import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/widgets/home_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.token});
 final String token;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homepageCubit(),
      child: HomePageBody(token: token,),
    );
  }
}
