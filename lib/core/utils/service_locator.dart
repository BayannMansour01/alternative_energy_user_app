import 'package:alternative_energy_user_app/features/previuosjobspage/data/repos/previous_jobs_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<PreviousJobsRepoImpl>(
    PreviousJobsRepoImpl(),
  );
  // getIt.registerSingleton<GroupsRepoImpl>(
  //   GroupsRepoImpl(),
  // );
  // getIt.registerSingleton<users_repo_impl>(
  //   users_repo_impl(),
  // );
}
