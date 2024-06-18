import 'dart:developer';
import 'package:alternative_energy_user_app/core/errors/failure.dart';
import 'package:alternative_energy_user_app/core/utils/dio_helper.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/logout_message_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class LogOutService {
  static Future<Either<Failure, LogoutResponse>> logout(
      {required String token}) async {
    try {
      var response = await DioHelper.getData(
        url: 'auth/logout',
        token: token,
      );
      log(response.toString());
      return right(LogoutResponse.fromJson(response.data));
    } catch (ex) {
      log('\nException: there is an error in logout method');
      log('\n$ex');
      if (ex is DioException) {
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
