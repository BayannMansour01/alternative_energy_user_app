import 'dart:developer';

import 'package:alternative_energy_user_app/core/utils/api/apis.dart';
import 'package:alternative_energy_user_app/features/register_screen/cubit/register_states.dart';
import 'package:alternative_energy_user_app/features/register_screen/register_service.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vpn/flutter_vpn.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  String? name, email, password, confirmPassword, phone;
  final formKey = GlobalKey<FormState>();

  RegisterCubit() : super(RegisterInitial());
  IconData icon = Icons.remove_red_eye;
  bool obscureText = true;
  IconData passwordSuffixIcon = Icons.remove_red_eye;

  void changePasswordSuffixIcon() {
    if (passwordSuffixIcon == Icons.remove_red_eye) {
      passwordSuffixIcon = FontAwesomeIcons.solidEyeSlash;
    } else {
      passwordSuffixIcon = Icons.remove_red_eye;
    }
    obscureText = !obscureText;
    emit(ChangePasswordState());
  }

  Future<void> register() async {
    emit(RegisterLoading());
    log('${password}');
    // إنشاء حساب في Firebase
    await APIs.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    ).then(
      (firebaseUser) async {
        log("firebase");
        log("${firebaseUser!.user!.email}");
        if (firebaseUser != null) {
          if (await APIs.userExists() == false) {
            await APIs.createUser(
              userName: name,
              // localUserID:,
            ).then((_) async {
              (await RegisterService.register(
                phone: phone!,
                name: name!,
                email: email!,
                password: password!,
                confirmPass: confirmPassword!,
                uid: firebaseUser.user!.uid.toString(),
              ))
                  .fold(
                (failure) {
                  log("Fail ${failure.toString()}");
                  emit(RegisterFailure(failureMsg: failure.toString()));
                },
                (userModel) {
                  log(userModel.toString());
                  emit(RegisterSuccess(userModel: userModel));
                },
              );
            }).catchError((ex) {
              log("firebase ${ex.toString()}");
              emit(RegisterFailure(failureMsg: ex.toString()));
            });
          }
        }
      },
    ).catchError((ex) {
      log(ex.toString());
      emit(RegisterFailure(failureMsg: ex.toString()));
    });
  }

  // Future<void> register() async {
  //   emit(RegisterLoading());
  //   (await RegisterService.register(
  //           phone: phone!,
  //           name: name!,
  //           email: email!,
  //           password: password!,
  //           confirmPass: confirmPassword!,
  //           uid: "lll"))
  //       .fold(
  //     (failure) {
  //       log("Fail ${failure.toString()}");
  //       emit(RegisterFailure(failureMsg: failure.toString()));
  //     },
  //     (userModel) async {
  //       // log(userModel.toString());
  //       await APIs.createUserWithEmailAndPassword(
  //         email: email!,
  //         password: password!,
  //       ).then(
  //         (value) async {
  //           log("00000000000000000000000000000000000000");
  //           log(value.toString());
  //           if (value != null) {
  //             if (await APIs.userExists() == false) {
  //               await APIs.createUser(
  //                 userName: name,
  //                 //  localUserID: 2,
  //               ).then((value) {
  //                 emit(RegisterSuccess(userModel: userModel));
  //               }).catchError(
  //                 (ex) {
  //                   log("firebase ${ex.toString()}");
  //                   emit(RegisterFailure(failureMsg: ex.toString()));
  //                 },
  //               );
  //             }
  //           }
  //         },
  //       ).catchError((ex) {
  //         log(ex.toString());
  //       });
  //       // emit(RegisterSuccess(userModel: userModel));
  //     },
  //   );
  //   // await FirebaseAPIs.createUserWithEmailAndPassword(
  //   //         email: email!, password: password!)
  //   //     .then(
  //   //   (value) async {
  //   //     if (value != null) {
  //   //       if (await FirebaseAPIs.userExists() == false) {
  //   //         await FirebaseAPIs.createUser(userName: name);
  //   //       }
  //   //       (await RegisterService.register(
  //   //               name: name!,
  //   //               email: email!,
  //   //               password: password!,
  //   //               confirmPass: confirmPassword!))
  //   //           .fold(
  //   //         (failure) {
  //   //           emit(RegisterFailure(failureMsg: failure.errorMessege));
  //   //         },
  //   //         (userModel) {
  //   //           emit(RegisterSuccess(userModel: userModel));
  //   //         },
  //   //       );
  //   //     } else {
  //   //       emit(RegisterFailure(
  //   //           failureMsg: 'Something Went Wrong, Please Try Again'));
  //   //     }
  //   //   },
  //   // ).catchError(
  //   //   // ignore: argument_type_not_assignable_to_error_handler
  //   //   () {
  //   //     emit(RegisterFailure(
  //   //         failureMsg: 'Something Went Wrong, Please Try Again'));
  //   //   },
  //   // );
  // }

  void changePasswordState() {
    obscureText = !obscureText;
    if (!obscureText) {
      icon = FontAwesomeIcons.solidEyeSlash;
      emit(RegisterInitial());
    } else {
      icon = FontAwesomeIcons.solidEye;
      emit(ChangePasswordState());
    }
  }
}
