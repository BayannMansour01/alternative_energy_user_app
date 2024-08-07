import 'dart:developer';

import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/errors/failure.dart';
import 'package:alternative_energy_user_app/core/utils/cache_helper.dart';
import 'package:alternative_energy_user_app/core/utils/dio_helper.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/device_model.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/solarSystemBody.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/solarSystemMoldel.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/repo/suggestSystem_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SuggestSystemRepoImpl extends SuggestSysyemRepo {
  @override
  Future<Either<Failure, List<Device>>> fetchDevices() async {
    try {
      Response data = await DioHelper.getData(
          url: AppConstants.fetchDevices,
          token: CacheHelper.getData(key: 'UserToken'));

      List<Device> devices = [];
      for (var item in data.data['devices']) {
        devices.add(Device.fromJson(item));
      }
      return right(devices);
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

  @override
  Future<Either<Failure, SolarSystem>> calculateSolarSystem(
      SolarSystembody body) async {
    try {
      final data = await DioHelper.postData(
        url: "${AppConstants.calculate}",
        token: CacheHelper.getData(key: 'UserToken'),
        body: {
          "SystemVoltage": body.systemVoltage,
          "InverterWatt": body.inverterWatt,
          "InverterStartWatt": body.inverterStartWatt,
          "TotalPowerNight": body.totalPowerNight,
          "PeakPowerNight": body.peakPowerNight,
          "pvCapacity": body.pvCapacity,
          "Aha": body.aha
        },
      );
      log('${data.data.toString()}');
      return right(SolarSystem.fromMap(data.data));
    } on Exception catch (e) {
      if (e is DioException) {
        log("Error : ${e.toString()}");
        return left(ServerFailure.fromDioException(e));
      }
      log("Error : ${e.toString()}");
      return left(ServerFailure(e.toString()));
    }
  }
}
