import 'package:alternative_energy_user_app/features/register_screen/models/message_model.dart';
import 'package:equatable/equatable.dart';

abstract class LoginStates {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginFailure extends LoginStates {
  final String failureMsg;

  LoginFailure({required this.failureMsg});
}

class LoginSuccess extends LoginStates {
  final MessageModel messageModel;

  LoginSuccess({required this.messageModel});
}

class ChangePasswordState extends LoginStates {}
