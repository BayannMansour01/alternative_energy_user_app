import 'package:alternative_energy_user_app/features/homepage/data/models/logout_message_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/my_order_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/order_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/product_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/proposed_system_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

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

class GetPanalesLoading extends homepageState {}

class GetPanalesFailure extends homepageState {
  final String errMessage;

  const GetPanalesFailure(this.errMessage);
}

class GetPanalesSuccess extends homepageState {
  final List<Product> Panales;
  GetPanalesSuccess(this.Panales);
}

class GetBatteriesLoading extends homepageState {}

class GetBatteriesFailure extends homepageState {
  final String errMessage;

  const GetBatteriesFailure(this.errMessage);
}

class GetBatteriesSuccess extends homepageState {
  final List<Product> Batteries;
  GetBatteriesSuccess(this.Batteries);
}

class GetInvertersLoading extends homepageState {}

class GetInvertersFailure extends homepageState {
  final String errMessage;

  const GetInvertersFailure(this.errMessage);
}

class GetInvertersSuccess extends homepageState {
  final List<Product> Inverters;
  GetInvertersSuccess(this.Inverters);
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
//////////////////////////////////

class SubmitOrderLoading extends homepageState {
  final List<ProductOrder> orders;

  const SubmitOrderLoading({this.orders = const []});

  @override
  List<Object> get props => [orders];
}

class OrderUpdatedState extends homepageState {
  final List<ProductOrder> orders;

  OrderUpdatedState(this.orders);
}

class SubmitOrderSuccess extends homepageState {
  final String message;

  const SubmitOrderSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class OrderAmountChanged extends homepageState {}

class SubmitOrderFailure extends homepageState {
  final String errMessage;

  const SubmitOrderFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class homepageOrdersCleared extends homepageState {}

class getMyAllOredersFilureState extends homepageState {
  final String errMessage;
  getMyAllOredersFilureState(this.errMessage);
}

class getMyAllOrederssSuccessState extends homepageState {
  final List<MyOrder> orders;
  getMyAllOrederssSuccessState(this.orders);
}

class ChangeActiveStepSuccess extends homepageState {}

// class homepageOrdersCleared extends homepageState{}

////////////////////
class MaintenanceInitial extends homepageState {}

class MaintenanceLoading extends homepageState {}

class MaintenanceSuccess extends homepageState {
  final String message;

  const MaintenanceSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class MaintenanceFailure extends homepageState {
  final String errMessage;

  const MaintenanceFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class MaintenanceImagePicked extends homepageState {
  final XFile image;

  const MaintenanceImagePicked(this.image);

  @override
  List<Object> get props => [image];
}
