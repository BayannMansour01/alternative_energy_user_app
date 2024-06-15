// ignore_for_file: argument_type_not_assignable_to_error_handler

import 'package:alternative_energy_user_app/features/chatScreen/presentation/manager/api/apis.dart';
import 'package:alternative_energy_user_app/features/register_screen/login_service.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  String email = '';
  String password = '';
  IconData icon = Icons.remove_red_eye;
  bool obscureText = true;
  final formKey = GlobalKey<FormState>();
  IconData passwordSuffixIcon = Icons.remove_red_eye;

  LoginCubit() : super(LoginInitial());
  void changePasswordSuffixIcon() {
    if (passwordSuffixIcon == Icons.remove_red_eye) {
      passwordSuffixIcon = FontAwesomeIcons.solidEyeSlash;
    } else {
      passwordSuffixIcon = Icons.remove_red_eye;
    }
    obscureText = !obscureText;
    emit(ChangePasswordState());
  }

  // Future<void> login() async {
  //   emit(LoginLoading());
  //   await FirebaseAPIs.signinWithEmailAndPassword(
  //           email: email, password: password)
  //       .then(
  //     (value) async {
  //       if (value != null) {
  //         (await LoginService.login(email: email, password: password)).fold(
  //           (failure) => emit(LoginFailure(failureMsg: failure.errorMessege)),
  //           (userModel) async {
  //             await FirebaseAPIs.getSelfInfo().then(
  //               (value) async {
  //                 if (await FirebaseAPIs.userExists() == false) {
  //                   await FirebaseAPIs.createUser(userName: userModel.name)
  //                       .then((value) {
  //                     emit(LoginSuccess(userModel: userModel));
  //                     // ignore: argument_type_not_assignable_to_error_handler
  //                   }).catchError(() {
  //                     emit(LoginFailure(
  //                         failureMsg:
  //                             'Something Went Wrong, Please Try Again'));
  //                   });
  //                 } else {
  //                   emit(LoginSuccess(userModel: userModel));
  //                 }
  //               },
  //             // ignore: argument_type_not_assignable_to_error_handler
  //             ).catchError(() {
  //               emit(LoginFailure(
  //                   failureMsg: 'Something Went Wrong, Please Try Again'));
  //             });
  //           },
  //         );
  //       } else {
  //         emit(LoginFailure(
  //             failureMsg: 'Something Went Wrong, Please Try Again'));
  //       }
  //     },
  //   ).catchError(
  //     // ignore: argument_type_not_assignable_to_error_handler
  //     () {
  //       emit(
  //           LoginFailure(failureMsg: 'Something Went Wrong, Please Try Again'));
  //     },
  //   );
  // }

  Future<void> login() async {
    emit(LoginLoading());

    await APIs.signinWithEmailAndPassword(email: email, password: password)
        .then(
      (value) async {
        (await LoginService.login(email: email, password: password)).fold(
          (failure) {
            emit(LoginFailure(failureMsg: failure.errorMessege));
          },
          (userModel) {
            emit(LoginSuccess(messageModel: userModel));
          },
        );
      },
    ).catchError(
      () {
        emit(
            LoginFailure(failureMsg: 'Something Went Wrong, Please Try Again'));
      },
    );
  }

  void changePasswordState() {
    obscureText = !obscureText;
    if (!obscureText) {
      icon = FontAwesomeIcons.solidEyeSlash;
      emit(LoginInitial());
    } else {
      icon = FontAwesomeIcons.solidEye;
      emit(ChangePasswordState());
    }
  }
}
