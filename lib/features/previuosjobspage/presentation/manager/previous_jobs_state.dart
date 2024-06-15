import 'package:equatable/equatable.dart';

abstract class PreviousJobsState extends Equatable {
  const PreviousJobsState();

  @override
  List<Object> get props => [];
}

class PreviousJobsInitial extends PreviousJobsState {}

class PreviousJobsLoading extends PreviousJobsState {}

class PreviousJobsFailure extends PreviousJobsState {
  final String errMessage;

  const PreviousJobsFailure(this.errMessage);
}

class PreviousJobsSuccess extends PreviousJobsState {
  // final List<GroupModel> groups;

  // const PreviousJobsSuccess(this.groups);
}

// class GetPreviousJobsSuccess extends PreviousJobsState {
//   final GetPreviousJobsResponse GetPreviousJobsResponse;

//   const GetPreviousJobsSuccess({required this.GetPreviousJobsResponse});
// }
