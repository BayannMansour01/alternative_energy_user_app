import 'package:alternative_energy_user_app/features/login_screen/cubit/login_cubit.dart';
import 'package:alternative_energy_user_app/features/login_screen/cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class PasswordTextField extends StatelessWidget {
  final String label;
  final TextInputAction? textInputAction;
  const PasswordTextField({
    super.key,
    required this.label,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      buildWhen: (previous, current) {
        if (current is ChangePasswordState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        final LoginCubit cubit = BlocProvider.of<LoginCubit>(context);

        return CustomTextField(
          prefixIcon: const Icon(Icons.lock),
          textInputAction: textInputAction,
          onFieldSubmitted: label == 'Password'
              ? null
              : (value) async {
                  await cubit.login();
                },
          suffixIcon: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              cubit.changePasswordSuffixIcon();
            },
            child: Icon(
              cubit.passwordSuffixIcon,
              color: Colors.grey,
            ),
          ),
          labelText: label,
          onChanged: (p0) {
            if (label == 'Confirm password') {
              cubit.confirm = p0;
            } else {
              cubit.password = p0;
            }
          },
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Required';
            } else {
              if (label == 'Confirm password') {
                if (cubit.confirm != cubit.password) {
                  return 'Passwords Does Not Match';
                }
              }
            }

            return null;
          },
          // onFieldSubmitted: (p0) async {
          //   if (cubit.formKey.currentState!.validate()) {
          //     // await cubit.Register();
          //   }
          // },
          // textInputAction: TextInputAction.go,
          obscureText: cubit.obscureText,
          maxLines: 1,
        );
      },
    );
  }
}
