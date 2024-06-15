import 'dart:developer';
import 'package:alternative_energy_user_app/core/errors/failure.dart';
import 'package:alternative_energy_user_app/core/utils/dio_helper.dart';
import 'package:alternative_energy_user_app/features/register_screen/models/message_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class GetMyInformationService {
  static Future<Either<Failure, MessageModel>> getMyInfo(
      {required String token}) async {
    try {
      var response = await DioHelper.getData(
        url: 'auth/me',
        token: token,
      );
      log(response.toString());
      return right(MessageModel.fromJson(response.data));
    } catch (ex) {
      log('\nException: there is an error in getMyInfo method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
