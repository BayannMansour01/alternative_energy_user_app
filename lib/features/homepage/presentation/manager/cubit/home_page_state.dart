import 'package:alternative_energy_user_app/features/homepage/data/models/logout_message_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/product_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/proposed_system_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class homepageState extends Equatable {
  const homepageState();

  @override
  List<Object> get props => [];
}

class homepageInitial extends homepageState {}

class homepageLoading extends homepageState {}

class homepageFailure extends homepageState {
  final String errMessage;

  const homepageFailure(this.errMessage);
}

class homepageSuccess extends homepageState {
  // final List<GroupModel> groups;

  // const homepageSuccess(this.groups);
}

class ChangeBottomNavigationBarIndex extends homepageState {}

class GetProposedSystemLoading extends homepageState {}

class GetProposedSystemFailure extends homepageState {
  final String errMessage;

  const GetProposedSystemFailure(this.errMessage);
}

class GetProposedSystemSuccess extends homepageState {
  final List<System> proposedSystem;
  GetProposedSystemSuccess(this.proposedSystem);
}

class GetProductsLoading extends homepageState {}

class GetProductsFailure extends homepageState {
  final String errMessage;

  const GetProductsFailure(this.errMessage);
}

class GetProductsSuccess extends homepageState {
  final List<Product> products;
  GetProductsSuccess(this.products);
}

class GetUserInfoLoading extends homepageState {}

class GetUserInfoFailure extends homepageState {
  final String errMessage;

  const GetUserInfoFailure(this.errMessage);
}

class GetUserInfoSuccess extends homepageState {
  final UserModel UserInfo;
  GetUserInfoSuccess(this.UserInfo);
}

class LogoutLoading extends homepageState {}

class LogoutFailure extends homepageState {
  final String errMessage;

  const LogoutFailure(this.errMessage);
}

class LogoutSuccess extends homepageState {
  final LogoutResponse message;
  LogoutSuccess(this.message);
}