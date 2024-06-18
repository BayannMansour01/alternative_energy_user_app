
import 'package:alternative_energy_user_app/features/previuosjobspage/data/models/job_model.dart';

abstract class JobDetailsState {}

class JobDetailsInitial extends JobDetailsState {}

class JobDetailsLoading extends JobDetailsState {}

class JobDetailsSuccess extends JobDetailsState {
  final Job job;
  JobDetailsSuccess(this.job);
}

class JobDetailsFailure extends JobDetailsState {
  final String errorMessage;
  JobDetailsFailure(this.errorMessage);
}
