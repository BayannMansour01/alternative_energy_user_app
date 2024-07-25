part of 'maintanance_cubit.dart';

sealed class MaintananceState extends Equatable {
  const MaintananceState();

  @override
  List<Object> get props => [];
}

final class MaintananceInitial extends MaintananceState {}

////////////////////
class MaintenanceInitial extends MaintananceState {}

class MaintenanceLoading extends MaintananceState {}

class MaintenanceSuccess extends MaintananceState {
  final String message;

  const MaintenanceSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class MaintenanceFailure extends MaintananceState {
  final String errMessage;

  const MaintenanceFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class MaintenanceImagePicked extends MaintananceState {
  final XFile image;

  const MaintenanceImagePicked(this.image);

  @override
  List<Object> get props => [image];
}
