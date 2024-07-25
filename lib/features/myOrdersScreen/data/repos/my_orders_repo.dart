import 'package:alternative_energy_user_app/core/errors/failure.dart';
import 'package:alternative_energy_user_app/features/myOrdersScreen/data/models/my_order_model.dart';
import 'package:dartz/dartz.dart';

abstract class MyOrdersRepo {
  Future<Either<Failure, List<MyOrder>>> fetchMyOrder();
}
