import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/errors/failure.dart';
import 'package:alternative_energy_user_app/core/utils/dio_helper.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/models/job_model.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/repos/previous_jobs_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class PreviousJobsRepoImpl extends PreviousJobsRepo {
 
  @override
  Future<Either<Failure, List<Job>>> fetchPreviuosJobs(String token) async {
    
    try {
      Response data =
          await DioHelper.getData(url: AppConstants.showAllPrevJobs,token: token);
      print("data:  $data");
      List<Job> jobs = [];
      for (var item in data.data['job']) {
        jobs.add(Job.fromJson(item));
      }
      return right(jobs);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioException(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}
