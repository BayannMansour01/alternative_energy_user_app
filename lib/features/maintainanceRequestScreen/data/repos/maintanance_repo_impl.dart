import 'dart:developer';

import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/errors/failure.dart';
import 'package:alternative_energy_user_app/core/utils/cache_helper.dart';
import 'package:alternative_energy_user_app/core/utils/dio_helper.dart';
import 'package:alternative_energy_user_app/features/maintainanceRequestScreen/data/models/message_order.dart';
import 'package:alternative_energy_user_app/features/maintainanceRequestScreen/data/repos/maintanance_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class MaintananceRepoImpl extends MaintananceRepo {
  @override
  Future<Either<Failure, OrderMessageModel>> submitMaintenanceRequest(
      FormData orderData) async {
    try {
      final response = await DioHelper.postData222(
        url: AppConstants.add_order,
        body: orderData,
        token: CacheHelper.getData(key: 'UserToken'),
      );

      return Right(OrderMessageModel.fromJson(response.data));
    } catch (ex) {
      log('There is an error in submitOrder method in HomeRepoImpl');
      print(ex.toString());
      if (ex is DioException) {
        return Left(ServerFailure(
          ex.response?.data['msg'] ?? 'Something Went Wrong, Please Try Again',
        ));
      }
      return Left(ServerFailure(ex.toString()));
    }
  }
}
