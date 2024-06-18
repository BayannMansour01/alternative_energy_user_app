import 'dart:developer';

import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/func/custom_progress_indicator.dart';
import 'package:alternative_energy_user_app/core/func/custom_snack_bar.dart';
import 'package:alternative_energy_user_app/core/utils/app_router.dart';
import 'package:alternative_energy_user_app/core/utils/size_config.dart';
import 'package:alternative_energy_user_app/core/widgets/custom_button.dart';
import 'package:alternative_energy_user_app/core/widgets/custom_text_field.dart';
import 'package:alternative_energy_user_app/core/widgets/space_widgets.dart';
import 'package:alternative_energy_user_app/features/login_screen/widgets/AppBarBorder.dart';
import 'package:alternative_energy_user_app/features/register_screen/cubit/register_cubit.dart';
import 'package:alternative_energy_user_app/features/register_screen/cubit/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatelessWidget {
  static const route = 'RegisterView';
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const Scaffold(
          body: RegisterViewBody(),
        ),
      ),
    );
  }
}

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
      if (state is RegisterLoading && !CustomProgressIndicator.isOpen) {
        CustomProgressIndicator.showProgressIndicator(context);
      } else {
        if (CustomProgressIndicator.isOpen) {
          context.pop();
        }

        if (state is RegisterFailure) {
          CustomSnackBar.showErrorSnackBar(context, message: state.failureMsg);
        } else if (state is RegisterSuccess) {
          context.pushReplacement(
            AppRouter.kLoginView,
          );
        }
      }
      if (state is RegisterFailure) {
        Navigator.pop(context);
        CustomSnackBar.showErrorSnackBar(
          context,
          message: state.failureMsg,
        );
      } else if (state is RegisterSuccess) {
        Navigator.pop(context);
        //  state.navigateToHome(context);
      } else if (state is RegisterLoading) {
        CustomProgressIndicator.showProgressIndicator(context);
      }
    }, buildWhen: (previous, current) {
      if (current is RegisterInitial) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      final RegisterCubit cubit = BlocProvider.of<RegisterCubit>(context);
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
                    "إنشاء حساب ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.grey),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize),
                width: SizeConfig.screenWidth,
                child: Form(
                  key: cubit.formKey,
                  child: Center(
                    child: Column(
                      children: [
                        const VerticalSpace(2),
                        CustomTextField(
                          prefixIcon: const Icon(Icons.person),
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            cubit.name = value;
                          }, //=>
                          labelText: 'اسم المستحدم',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'required';
                            }
                            return null;
                          },
                        ),
                        const VerticalSpace(2),
                        CustomTextField(
                          prefixIcon: const Icon(Icons.phone),
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            cubit.phone = value;
                          }, //=>
                          labelText: 'الهاتف',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'required';
                            }
                            return null;
                          },
                        ),
                        const VerticalSpace(2),
                        CustomTextField(
                          prefixIcon: const Icon(Icons.email),
                          textInputAction: TextInputAction.next,
                          labelText: 'البريد الإلكتروني',
                          onChanged: (p0) {
                            cubit.email = p0;
                          }, // =>
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'required';
                            } else {
                              if (!RegExp(r'\S+@\S+\.\S+')
                                  .hasMatch(value.toString())) {
                                return "Please enter a valid email address";
                              }
                            }
                            return null;
                          },
                        ),
                        const VerticalSpace(2),
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
                            if (cubit.formKey.currentState!.validate()) {
                              await cubit.register();
                            }
                          },
                          textInputAction: TextInputAction.go,
                          obscureText: cubit.obscureText,
                          maxLines: 1,
                        ),
                        const VerticalSpace(2),
                        CustomTextField(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'تأكيد كلمة السر',
                          obscureText: cubit.obscureText,
                          maxLines: 1,
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
                          onChanged: (value) => cubit.confirmPassword = value,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'required';
                            } else if (value != cubit.password) {
                              return "Passwords don't match";
                            }
                            return null;
                          },
                        ),
                        const VerticalSpace(2),
                        CustomButton(
                          text: '  إنشاء حساب',
                          color: AppConstants.blueColor,
                          onTap: () async {
                            if (cubit.formKey.currentState!.validate()) {
                              await cubit.register();
                            }
                          },
                        ),
                        const VerticalSpace(3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "لديك حساب مسبقاً؟",
                              style: TextStyle(
                                fontSize: SizeConfig.defaultSize,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text(
                                'تسجيل دخول',
                                style: TextStyle(
                                  color: AppConstants.blueColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

// class RegisterViewBody extends StatelessWidget {
//   const RegisterViewBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<RegisterCubit, RegisterStates>(
//       builder: (context, state) {
//         if (state is RegisterLoading) {
//           return Center(
//             child: CircularProgressIndicator(
//               color: Colors.white,
//               strokeWidth: 3,
//             ),
//           );
//         } else if (state is RegisterSuccess) {
//           return const LoginView();
//         } else {
//           return _Body(
//             registerCubit: BlocProvider.of<RegisterCubit>(context),
//           );
//         }
//       },
//       listener: (context, state) {
//         if (state is RegisterFailure) {
//           CustomSnackBar.showErrorSnackBar(context, message: state.failureMsg);
//         }
//       },
//     );
//   }
// }

// class _Body extends StatelessWidget {
//   final RegisterCubit registerCubit;
//   const _Body({required this.registerCubit});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Form(
//         key: registerCubit.formKey,
//         child: Column(
//           children: [
//             SizedBox(
//               width: 50,
//               height: 95,
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Create Your Account',
//               style: TextStyle(
//                 color: AppConstants.blueColor,
//                 fontSize: 27,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const Text(
//               'Please Enter Your Info To Get Started',
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontStyle: FontStyle.italic,
//               ),
//             ),
//             SizedBox(height: 60),
//             CustomTextField(
//               labelText: 'Name',
//               suffixIcon: const Icon(
//                 Icons.account_circle,
//                 color: AppConstants.backgroundColor,
//                 size: 40,
//               ),
//               //  textCapitalization: TextCapitalization.sentences,

//               onChanged: (value) => registerCubit.name = value,
//             ),
//             SizedBox(height: 12),
//             CustomTextField(
//               keyboardType: TextInputType.emailAddress,
//               suffixIcon: const Icon(
//                 Icons.email,
//                 color: AppConstants.gradient1,
//                 size: 40,
//               ),
//               labelText: 'Email',
//               onChanged: (value) => registerCubit.email = value,
//               validator: (value) {
//                 if (value?.isEmpty ?? true) {
//                   return 'required';
//                 } else {
//                   if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value.toString())) {
//                     return "Please enter a valid email address";
//                   }
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 12),
//             CustomTextField(
//               keyboardType: TextInputType.phone,
//               suffixIcon: const Icon(
//                 Icons.phone,
//                 color: AppConstants.gradient1,
//                 size: 40,
//               ),
//               labelText: 'phone',
//               onChanged: (value) => registerCubit.phone = value,
//               validator: (value) {
//                 if (value?.isEmpty ?? true) {
//                   return 'required';
//                 }
//                 // else {
//                 //   if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value.toString())) {
//                 //     return "Please enter a valid email address";
//                 //   }
//                 // }
//                 return null;
//               },
//             ),
//             SizedBox(height: 12),
//             CustomTextField(
//               prefixIcon: Icon(Icons.lock),
//               labelText: 'Password',
//               // obscureText: true,
//               suffixIcon: const Icon(
//                 Icons.password,
//                 color: AppConstants.gradient1,
//                 size: 40,
//               ),
//               onChanged: (value) => registerCubit.password = value,
//               validator: (value) {
//                 if (value?.isEmpty ?? true) {
//                   return 'required';
//                 } else if (value!.length < 9) {
//                   return 'Password must be at least 9 character';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 12),
//             CustomTextField(
//               labelText: 'Confirm Password',
//               //obscureText: true,
//               suffixIcon: const Icon(
//                 Icons.password,
//                 color: AppConstants.gradient3,
//                 size: 7,
//               ),
//               onChanged: (value) => registerCubit.confirmPassword = value,
//               validator: (value) {
//                 if (value?.isEmpty ?? true) {
//                   return 'required';
//                 } else if (value != registerCubit.password) {
//                   return "Passwords don't match";
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 8),
//             CustomButton(
//               text: 'Register',
//               onTap: () async {
//                 if (registerCubit.formKey.currentState!.validate()) {
//                   await registerCubit.register();
//                 }
//               },
//             ),
//             SizedBox(height: 7),
//           ],
//         ),
//       ),
//     );
//   }
// }
