import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/errors/failure.dart';
import 'package:alternative_energy_user_app/core/utils/cache_helper.dart';
import 'package:alternative_energy_user_app/core/utils/dio_helper.dart';
import 'package:alternative_energy_user_app/features/myOrdersScreen/data/models/my_order_model.dart';
import 'package:alternative_energy_user_app/features/myOrdersScreen/data/repos/my_orders_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class MyOrdersRepoImpl extends MyOrdersRepo {
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
