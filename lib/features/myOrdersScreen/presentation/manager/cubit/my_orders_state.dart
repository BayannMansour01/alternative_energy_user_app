part of 'my_orders_cubit.dart';

sealed class MyOrdersState extends Equatable {
  const MyOrdersState();

  @override
  List<Object> get props => [];
}

final class MyOrdersInitial extends MyOrdersState {}

class getMyAllOredersFilureState extends MyOrdersState {
  final String errMessage;
  getMyAllOredersFilureState(this.errMessage);
}

class getMyAllOredersLoadingState extends MyOrdersState {}

class getMyAllOrederssSuccessState extends MyOrdersState {
  final List<MyOrder> orders;
  getMyAllOrederssSuccessState(this.orders);
}

class ChangeActiveStepSuccess extends MyOrdersState {}
