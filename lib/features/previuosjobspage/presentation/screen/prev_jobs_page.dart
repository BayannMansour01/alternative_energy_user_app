import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/models/job_model.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/repos/previous_jobs_repo_impl.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/presentation/manager/previous_jobs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/prev_jobs_body.dart';

class JobListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PreviousJobsCubit(
              getIt.get<PreviousJobsRepoImpl>(),
            )..fetchAllPrevJobs(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "قائمة الأعمال السابقة",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: PreviousJobsBody(),
        ));
  }
}
