import 'package:alternative_energy_user_app/core/errors/failure.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/models/job_model.dart';
import 'package:dartz/dartz.dart';



abstract class JobDetailsRepo {
  Future<Either<Failure, Job>> fetchJobDetails(int jobId,String token);
}
