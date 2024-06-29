import 'dart:developer';

import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/errors/failure.dart';
import 'package:alternative_energy_user_app/core/utils/cache_helper.dart';
import 'package:alternative_energy_user_app/core/utils/dio_helper.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/logout_message_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/my_order_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/order_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/product_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/proposed_system_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/user_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/repos/home_repo.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/models/job_model.dart';
import 'package:alternative_energy_user_app/features/register_screen/models/message_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends homeRepo {
  @override
  Future<Either<Failure, List<System>>> fetchProposedSystems() async {
    try {
      Response data = await DioHelper.getData(
          url: AppConstants.getAllProposedSystem,
          token: CacheHelper.getData(key: 'Token'));
      log("data:  $data");
      List<System> proposedSystem = [];
      for (var item in data.data['systems']) {
        proposedSystem.add(System.fromJson(item));
      }
      return right(proposedSystem);
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
  Future<Either<Failure, List<Product>>> fetchPanales() async {
    try {
      Response data = await DioHelper.getData(
          url: AppConstants.showAllPanales,
          token: CacheHelper.getData(key: 'Token'));
      log("data:  $data");
      List<Product> Products = [];
      for (var item in data.data['products']) {
        Products.add(Product.fromJson(item));
      }
      return right(Products);
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
  Future<Either<Failure, List<Product>>> fetchbatteries() async {
    try {
      Response data = await DioHelper.getData(
          url: AppConstants.showAllbatteries,
          token: CacheHelper.getData(key: 'Token'));
      log("data:  $data");
      List<Product> Products = [];
      for (var item in data.data['products']) {
        Products.add(Product.fromJson(item));
      }
      return right(Products);
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
  Future<Either<Failure, List<Product>>> fetchInverters() async {
    try {
      Response data = await DioHelper.getData(
          url: AppConstants.showAllInverters,
          token: CacheHelper.getData(key: 'Token'));
      log("data:  $data");
      List<Product> Products = [];
      for (var item in data.data['products']) {
        Products.add(Product.fromJson(item));
      }
      return right(Products);
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

  Future<Either<Failure, List<Product>>> fetchProducts() async {
    try {
      Response data = await DioHelper.getData(
          url: AppConstants.showAllProducts,
          token: CacheHelper.getData(key: 'Token'));
      log("data:  $data");
      List<Product> Products = [];
      for (var item in data.data['products']) {
        Products.add(Product.fromJson(item));
      }
      return right(Products);
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
  Future<Either<Failure, UserModel>> fetchuserinfo() async {
    try {
      Response data = await DioHelper.getData(
          url: AppConstants.me, token: CacheHelper.getData(key: 'Token'));
      log("data:  $data");

      UserModel user = UserModel.fromJson(data.data);
      return right(user);
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
  Future<Either<Failure, LogoutResponse>> Loguot(
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

  @override
  Future<Either<Failure, MessageModel>> submitOrder(Order1 order) async {
    try {
      final response = await DioHelper.postData(
        url: AppConstants.add_order,
        body: order.toJson(),
        token: CacheHelper.getData(key: 'Token'),
      );

      return Right(MessageModel.fromJson(response.data));
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

  @override
  Future<Either<Failure, List<MyOrder>>> fetchMyOrder() async {
    try {
      Response data = await DioHelper.getData(
          url: AppConstants.showAllMyorder,
          token: CacheHelper.getData(key: 'Token'));

      List<MyOrder> MyOrderDatas = [];

      for (var item in data.data['orders']) {
        MyOrderDatas.add(MyOrder.fromJson(item['order']));
      }
      // log("MyOrderDatas:  ${MyOrderDatas.length}");
      return right(MyOrderDatas);
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
}
