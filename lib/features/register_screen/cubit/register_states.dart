import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/widgets/message.dart';
import 'package:alternative_energy_user_app/features/register_screen/models/message_model.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterStates {
  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterStates {}

final class RegisterLoading extends RegisterStates {}

final class RegisterFailure extends RegisterStates {
  final String failureMsg;

  RegisterFailure({required this.failureMsg});
}

final class ChangePasswordState extends RegisterStates {}

final class RegisterSuccess extends RegisterStates {
  final MessageModel userModel;

  RegisterSuccess({required this.userModel});
}

// final class ChangePasswordState extends RegisterStates {}
