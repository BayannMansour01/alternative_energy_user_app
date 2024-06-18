
import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/errors/failure.dart';
import 'package:alternative_energy_user_app/core/utils/dio_helper.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/models/job_model.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/repos/prev_job_details_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
class JobDetailsRepoImpl extends JobDetailsRepo {
  @override
  Future<Either<Failure, Job>> fetchJobDetails(int jobId, String token) async {
    try {
      print("Fetching job details for jobId: $jobId with token: $token");
      Response response = await DioHelper.getData(url: 'PreviousJobs/show/$jobId', token: token);
      print("Data received: ${response.data}");
      
      // Ensure the JSON data structure matches the expected format
      if (response.data is Map && response.data['job'] is List && response.data['job'].isNotEmpty) {
        Job job = Job.fromJson(response.data['job'][0]);
        return right(job);
      } else {
        throw StateError('Unexpected JSON structure');
      }
    } on Exception catch (e) {
      if (e is DioException) {
        print("DioException: ${e.message}");
        return left(ServerFailure.fromDioException(e));
      }
      print("Exception: ${e.toString()}");
      return left(ServerFailure(e.toString()));
    }
  }
}

