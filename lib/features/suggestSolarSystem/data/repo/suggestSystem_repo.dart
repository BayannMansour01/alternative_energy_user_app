import 'package:alternative_energy_user_app/core/errors/failure.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/order_model.dart';
import 'package:alternative_energy_user_app/features/maintainanceRequestScreen/data/models/message_order.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/device_model.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/solarSystemBody.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/solarSystemMoldel.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/suggestedProducts.dart';
import 'package:dartz/dartz.dart';

abstract class SuggestSysyemRepo {
  Future<Either<Failure, List<Device>>> fetchDevices();
  Future<Either<Failure, Suggestedproducts>> calculateSolarSystem(
      Map<String, dynamic> body);
  Future<Either<Failure, OrderMessageModel>> submitOrder(Order1 order);
}
