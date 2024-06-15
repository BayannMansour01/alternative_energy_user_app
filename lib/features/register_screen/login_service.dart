import 'dart:developer';
import 'package:alternative_energy_user_app/core/errors/failure.dart';
import 'package:alternative_energy_user_app/core/utils/dio_helper.dart';
import 'package:alternative_energy_user_app/features/register_screen/models/message_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class LoginService {
  static Future<Either<Failure, MessageModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'auth/login',
        body: {
          "email": email,
          "password": password,
        },
      );
      log(response.toString());

      return right(MessageModel.fromJson(response.data));
    } catch (ex) {
      log('\nException: there is an error in login method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
