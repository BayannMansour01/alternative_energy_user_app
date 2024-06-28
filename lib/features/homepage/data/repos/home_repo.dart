import 'package:alternative_energy_user_app/core/errors/failure.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/logout_message_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/order_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/product_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/proposed_system_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/user_model.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/models/job_model.dart';
import 'package:alternative_energy_user_app/features/register_screen/models/message_model.dart';
import 'package:dartz/dartz.dart';

abstract class homeRepo {
  Future<Either<Failure, List<System>>> fetchProposedSystems();
  Future<Either<Failure, List<Product>>> fetchProducts();
  Future<Either<Failure, List<Product>>> fetchPanales();
  Future<Either<Failure, List<Product>>> fetchbatteries();
  Future<Either<Failure, List<Product>>> fetchInverters();
  Future<Either<Failure, UserModel>> fetchuserinfo();
  Future<Either<Failure, LogoutResponse>> Loguot({required String token});
   Future<Either<Failure, MessageModel>> submitOrder(Order1 orderData);
}
