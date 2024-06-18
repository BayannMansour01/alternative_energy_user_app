import 'package:alternative_energy_user_app/features/previuosjobspage/data/models/job_model.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/repos/prev_job_details_repo.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/presentation/manager/prev_job_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class JobDetailsCubit extends Cubit<JobDetailsState> {
  Job? job;
  final JobDetailsRepo repo;

  JobDetailsCubit(this.repo) : super(JobDetailsInitial());

  Future<void> fetchJobDetails(int jobId, String token) async {
    emit(JobDetailsLoading());
    var result = await repo.fetchJobDetails(jobId, token);
    result.fold(
      (failure) {
        print("Failed to fetch job details: ${failure.errorMessege}");
        emit(JobDetailsFailure(failure.errorMessege));
      },
      (job) {
        this.job = job;
        print("Job details fetched successfully: ${job.title}");
        emit(JobDetailsSuccess(job));
      },
    );
  }
}
