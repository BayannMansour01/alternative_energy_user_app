part of 'suggest_system_cubit.dart';

sealed class SuggestSystemState extends Equatable {
  const SuggestSystemState();

  @override
  List<Object> get props => [];
}

final class SuggestSystemInitial extends SuggestSystemState {}

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
  final SolarSystem response;
  CalculateSystemSuccessState(this.response);
}

class CalculateSystemLoadingState extends SuggestSystemState {}

class CalculateSystemErrorState extends SuggestSystemState {
  final String errMessage;
  CalculateSystemErrorState(this.errMessage);
}
