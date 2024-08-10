import 'package:alternative_energy_user_app/core/errors/failure.dart';
import 'package:alternative_energy_user_app/features/maintainanceRequestScreen/data/models/message_order.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class MaintananceRepo {
  Future<Either<Failure, OrderMessageModel>> submitMaintenanceRequest(
      FormData orderData);
}
