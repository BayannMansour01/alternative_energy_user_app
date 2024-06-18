import 'package:alternative_energy_user_app/features/previuosjobspage/data/models/job_model.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/repos/previous_jobs_repo.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/presentation/manager/previous_jobs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviousJobsCubit extends Cubit<PreviousJobsState> {
  PreviousJobsCubit(this.Repo) : super(PreviousJobsInitial());
  final PreviousJobsRepo Repo;
  // String groupname = '';
  List<Job> jobs = [];

  Future<void> fetchAllPrevJobs({required String token}) async {
    emit(PreviousJobsLoading());
    var result = await Repo.fetchPreviuosJobs(token);
    print("result $result");
    result.fold((failure) {
      emit(PreviousJobsFailure(failure.errorMessege));
    }, (data) {
      this.jobs = data;
      emit(PreviousJobsSuccess());
    });
  }
  

// Future<void> fetchPrevJobsDetails() async {
//     emit(PreviousJobsLoading());
//     var result = await Repo.fetchJobDetails();
//     print("result $result");
//     result.fold((failure) {
//       emit(PreviousJobsFailure(failure.errorMessege));
//     }, (data) {
//       this.jobs = data;
//       emit(PreviousJobsSuccess());
//     });
//   }

//   Future<void> createGroup() async {
//     (await groupsrepo.createGroup(
//       name: groupname,
//       token: await CacheHelper.getData(key: 'Token'),
//     ))
//         .fold(
//       (failure) => emit(UserGroupsFailure(failure.errorMessege)),
//       (response) => emit(CreateGroupSuccess(createGroupResponse: response)),
//     );
//   }
}
