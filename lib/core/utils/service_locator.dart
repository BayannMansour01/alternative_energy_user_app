import 'package:alternative_energy_user_app/features/homepage/data/models/proposed_system_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/repos/home_repo_impl.dart';
import 'package:alternative_energy_user_app/features/maintainanceRequestScreen/data/repos/maintanance_repo_impl.dart';
import 'package:alternative_energy_user_app/features/myOrdersScreen/data/repos/my_orders_repo_impl.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/repos/previous_jobs_repo_impl.dart';
import 'package:alternative_energy_user_app/features/profile_screen/data/repo/profile_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<PreviousJobsRepoImpl>(
    PreviousJobsRepoImpl(),
  );
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(),
  );
  getIt.registerSingleton<ProfileRepoImpl>(
    ProfileRepoImpl(),
  );
  getIt.registerSingleton<MyOrdersRepoImpl>(
    MyOrdersRepoImpl(),
  );
  getIt.registerSingleton<MaintananceRepoImpl>(
    MaintananceRepoImpl(),
  );
  // getIt.registerSingleton<users_repo_impl>(
  //   users_repo_impl(),
  // );
}
