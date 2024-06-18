import 'package:alternative_energy_user_app/core/utils/cache_helper.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/product_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/proposed_system_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/user_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/repos/home_repo.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class homepageCubit extends Cubit<homepageState> {
  homepageCubit(this.Repo) : super(homepageInitial());
  bool listining = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int bottomNavigationBarIndex = 0;
  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: 'المحادثات',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.archive),
      label: 'الأعمال السابقة',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.archive),
      label: 'الأعمال السابقة',
    ),
  ];

  void changeBottomNavigationBarIndex(int index) {
    emit(homepageInitial());
    bottomNavigationBarIndex = index;
    emit(ChangeBottomNavigationBarIndex());
  }

  final homeRepo Repo;
  // String groupname = '';
  List<System> proposedSystem = [];

  List<Product> products = [];

  Future<void> fetchAllProposedSystem() async {
    emit(GetProposedSystemLoading());
    var result = await Repo.fetchProposedSystems();
    print("result $result");
    result.fold((failure) {
      emit(GetProposedSystemFailure((failure.errorMessege)));
    }, (data) {
      proposedSystem = data;
      emit(GetProposedSystemSuccess(proposedSystem));
    });
  }

  Future<void> fetchAllProducts() async {
    emit(GetProductsLoading());
    var result = await Repo.fetchProducts();
    print("result $result");
    result.fold((failure) {
      emit(GetProductsFailure(((failure.errorMessege))));
    }, (data) {
      products = data;
      emit(GetProductsSuccess(products));
    });
  }

  UserModel? userInfo;

  Future<void> fetchUserInfo() async {
    emit(GetUserInfoLoading());
    var result = await Repo.fetchuserinfo();
    result.fold((failure) {
      emit(GetUserInfoFailure(((failure.errorMessege))));
    }, (data) {
      userInfo = data;
      emit(GetUserInfoSuccess(data));
    });
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    var result = await Repo.Loguot(token: CacheHelper.getData(key: 'Token'));
    result.fold((failure) {
      emit(LogoutFailure(((failure.errorMessege))));
    }, (data) {
      emit(LogoutSuccess((data)));
    });
  }
}
