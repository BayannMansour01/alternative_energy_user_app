import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/func/custom_progress_indicator.dart';
import 'package:alternative_energy_user_app/core/func/custom_snack_bar.dart';
import 'package:alternative_energy_user_app/core/utils/app_router.dart';
import 'package:alternative_energy_user_app/core/utils/cache_helper.dart';
import 'package:alternative_energy_user_app/core/utils/size_config.dart';
import 'package:alternative_energy_user_app/core/widgets/custom_button.dart';
import 'package:alternative_energy_user_app/core/widgets/custom_text_field.dart';
import 'package:alternative_energy_user_app/core/widgets/space_widgets.dart';
import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/conversations_screen.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/home_page.dart';
import 'package:alternative_energy_user_app/features/login_screen/widgets/AppBarBorder.dart';
import 'package:alternative_energy_user_app/features/login_screen/widgets/password_suffix_icon.dart';
import 'package:alternative_energy_user_app/features/login_screen/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../register_screen/register_screen.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_states.dart';
import 'login_design_section.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginLoading && !CustomProgressIndicator.isOpen) {
          CustomProgressIndicator.showProgressIndicator(context);
        } else {
          if (CustomProgressIndicator.isOpen) context.pop();
          if (state is LoginFailure) {
            CustomSnackBar.showErrorSnackBar(
              context,
              message: state.failureMsg,
            );
          } else if (state is LoginSuccess) {
            CacheHelper.saveData(
                key: 'UserToken', value: state.messageModel.token);
            CacheHelper.saveData(
                key: 'token_expiry',
                value: DateTime.now().millisecondsSinceEpoch + 3600 * 1000);
            context.pushReplacement(
              AppRouter.khomeView,
              // extra: state.userModel.token,
            );
          }
        }
      },
      buildWhen: (prev, cur) => cur is LoginInitial,
      builder: (context, state) {
        LoginCubit cubit = BlocProvider.of<LoginCubit>(context);
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 280,
                  width: 1300,
                  decoration: ShapeDecoration(
                    color: AppConstants.blueColor,
                    shape: AppBarBorder(),
                    shadows: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 18.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Center(
                      child: Text(
                    "تسجيل الدخول ",
                    style: TextStyle(color: Colors.grey, fontSize: 40),
                  )),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(30)),
                  ),
                  child: Form(
                      key: cubit.formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'مطلوب';
                              } else {
                                if (!RegExp(r'\S+@\S+\.\S+')
                                    .hasMatch(value.toString())) {
                                  return "الرجاء إدخال بريد الكتروني صالح";
                                }
                              }
                              return null;
                            },
                            prefixIcon: Icon(Icons.email),
                            textInputAction: TextInputAction.next,
                            labelText: 'البريد الإلكتروني',
                            onChanged: (p0) => cubit.email = p0,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const VerticalSpace(1),
                          CustomTextField(
                            prefixIcon: Icon(Icons.lock),
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
                            labelText: 'كلمة السر',
                            onChanged: (p0) => cubit.password = p0,
                            onFieldSubmitted: (p0) async {
                              // if (cubit.formKey.currentState!.validate()) {
                              //   await cubit.login();
                              //   }
                            },
                            textInputAction: TextInputAction.go,
                            obscureText: cubit.obscureText,
                            maxLines: 1,
                          ),
                          const VerticalSpace(1),
                          CustomButton(
                            text: 'تسجيل الدخول ',
                            onTap: () async {
                              if (cubit.formKey.currentState!.validate()) {
                                await cubit.login();
                              }
                              // CacheHelper.getData(key: 'UserToken');
                            },
                          ),
                          const VerticalSpace(3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "ليس لديك حساب؟",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.push(AppRouter.kRegisterView);
                                },
                                child: Text(
                                  'سجل الآن ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: AppConstants.blueColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
