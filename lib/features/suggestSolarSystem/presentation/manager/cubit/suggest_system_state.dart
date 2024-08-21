part of 'suggest_system_cubit.dart';

sealed class SuggestSystemState {
  const SuggestSystemState();

  @override
  List<Object> get props => [];
}

final class SuggestSystemInitial extends SuggestSystemState {}

class SuggestSystemUpdatedpage extends SuggestSystemState {
  final double page;

  SuggestSystemUpdatedpage(this.page);
}

class SliderValueChanged extends SuggestSystemState {
  final double newValue;

  SliderValueChanged(this.newValue);
}

class SuggestSystemUpdatedHoursRange extends SuggestSystemState {
  final RangeValues hoursRange;

  SuggestSystemUpdatedHoursRange(this.hoursRange);
}

class SuggestSystemUpdatedPowerRange extends SuggestSystemState {
  final RangeValues powerRange;

  SuggestSystemUpdatedPowerRange(this.powerRange);
}

final class DeviceInitial extends SuggestSystemState {}

class getDvicesFilureState extends SuggestSystemState {
  final String errMessage;
  getDvicesFilureState(this.errMessage);
}

class getDvicessSuccessState extends SuggestSystemState {
  final List<Device> devices;
  getDvicessSuccessState(this.devices);
}

class DevicesFromListToMap extends SuggestSystemState {}

class SelectedevicesFromListToMap extends SuggestSystemState {}

class DeviceWattChanged extends SuggestSystemState {}

class addSelelctDevice extends SuggestSystemState {}

class CalculateSystemSuccessState extends SuggestSystemState {
  final Suggestedproducts response;
  CalculateSystemSuccessState(this.response);
}

class CalculateSystemLoadingState extends SuggestSystemState {}

class CalculateSystemErrorState extends SuggestSystemState {
  final String errMessage;
  CalculateSystemErrorState(this.errMessage);
}

class DeviceAmountChanged extends SuggestSystemState {}

class SuggestSystemUpdated extends SuggestSystemState {}

class SuggestSystemLoading extends SuggestSystemState {}

class SuggestSystemError extends SuggestSystemState {}

class SubmitOrderSuccess extends SuggestSystemState {
  final String message;

  const SubmitOrderSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class OrderAmountChanged extends SuggestSystemState {}

class SubmitOrderFailure extends SuggestSystemState {
  final String errMessage;

  const SubmitOrderFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class homepageOrdersCleared extends SuggestSystemState {}

class SubmitOrderLoading extends SuggestSystemState {
  final List<ProductOrder> orders;

  const SubmitOrderLoading({this.orders = const []});

  @override
  List<Object> get props => [orders];
}
