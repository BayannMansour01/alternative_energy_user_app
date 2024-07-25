import 'package:alternative_energy_user_app/features/myOrdersScreen/data/models/my_order_model.dart';
import 'package:alternative_energy_user_app/features/myOrdersScreen/data/repos/my_orders_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit(this.Repo) : super(MyOrdersInitial());
  List<MyOrder> MyOrders = [];
  final MyOrdersRepo Repo;
  int status = 0;
  void changeActiveStepper(int index) {
    status = index;
    emit(ChangeActiveStepSuccess());
  }

  void fetchAllmyOrders() async {
    var result = await Repo.fetchMyOrder();
    result.fold((failure) {
      emit(getMyAllOredersFilureState(failure.errorMessege));
    }, (data) {
      MyOrders = data;
      // CacheHelper.saveData(key: 'UserID', value: userInfo?.id);
      emit(getMyAllOrederssSuccessState(MyOrders));
    });
  }
}
