import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_states.dart';

class PasswordSuffixIcon extends StatelessWidget {
  const PasswordSuffixIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);

        return InkWell(
          borderRadius: BorderRadius.circular(.25),
          onTap: () {
            loginCubit.changePasswordSuffixIcon();
          },
          child: Icon(
            loginCubit.icon,
            color: AppConstants.blueColor,
          ),
        );
      },
    );
  }
}
