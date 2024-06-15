import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/func/custom_progress_indicator.dart';
import 'package:alternative_energy_user_app/core/func/custom_snack_bar.dart';
import 'package:alternative_energy_user_app/core/utils/app_router.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/models/job_model.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/presentation/manager/previous_jobs_cubit.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/presentation/manager/previous_jobs_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PreviousJobsBody extends StatelessWidget {
  const PreviousJobsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PreviousJobsCubit>(context);

    return BlocConsumer<PreviousJobsCubit, PreviousJobsState>(
      listener: (context, state) async {
        if (state is PreviousJobsLoading && !CustomProgressIndicator.isOpen) {
          CustomProgressIndicator.showProgressIndicator(context);
        } else {
          if (CustomProgressIndicator.isOpen) {
            context.pop();
          }
          if (state is PreviousJobsFailure) {
            CustomSnackBar.showErrorSnackBar(context,
                message: state.errMessage);
          }
        }
      },
      builder: (context, state) {
        return ListView.builder(
          itemCount: cubit.jobs.length,
          itemBuilder: (context, index) {
            return jobItem(
              job: cubit.jobs[index],
            );
          },
        );
      },
    );
  }
}

class jobItem extends StatelessWidget {
  final Job job;
  const jobItem({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppConstants.orangeColor.withOpacity(0.8),
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${job.title} ',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text('${job.disc} '),
            SizedBox(height: 5.0),
            Text(
              '${job.createdAt} ',
              style: TextStyle(color: Colors.grey),
            ),
            if (job.images.isNotEmpty) ...[
              SizedBox(height: 10.0),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: job.images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.network(
                        'http://192.168.1.107:8000/' + job.images[index].image,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
