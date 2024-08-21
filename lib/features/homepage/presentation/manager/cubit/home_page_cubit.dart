import 'dart:io';

import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/cache_helper.dart';
import 'package:alternative_energy_user_app/core/utils/size_config.dart';
import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/chat_screen.dart';
import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/conversations_screen.dart';

import 'package:alternative_energy_user_app/features/myOrdersScreen/data/models/my_order_model.dart';

import 'package:alternative_energy_user_app/features/homepage/data/models/maintenanceRequest_model.dart';

import 'package:alternative_energy_user_app/features/homepage/data/models/order_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/product_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/proposed_system_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/user_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/repos/home_repo.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/home_page.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/presentation/screen/widgets/prev_jobs_body.dart';
import 'package:alternative_energy_user_app/features/profile_screen/presentation/screens/widgets/profile_body.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/screens/SuggestsystemScreen.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class homepageCubit extends Cubit<homepageState> {
  homepageCubit(this.Repo) : super(homepageInitial());
  bool listining = false;

  String location = "";

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int bottomNavigationBarIndex = 1;
  // List<BottomNavigationBarItem> bottomNavigationBarItems = [
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.message),
  //     label: 'المحادثات',
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(FontAwesomeIcons.home),
  //     label: 'الرئيسية',
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(FontAwesomeIcons.archive),
  //     label: 'الأعمال السابقة',
  //   ),
  //   BottomNavigationBarItem(
  //     icon: SizedBox(
  //       width: 25,
  //       height: 25,
  //       child: SvgPicture.asset(
  //         'assets/images/battery.svg', // Your SVG asset path
  //         color: bottomNavigationBarIndex == 3 ? Colors.blue : Colors.grey,
  //       ),
  //     ),
  //     label: 'اقتراح منظومة',
  //   )
  // ];
  List<BottomNavigationBarItem> get bottomNavigationBarItems {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.message),
        label: 'المحادثات',
      ),
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.home),
        label: 'الرئيسية',
      ),
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.archive),
        label: 'الأعمال السابقة',
      ),
      BottomNavigationBarItem(
        icon: SizedBox(
          width: 25,
          height: 25,
          child: SvgPicture.asset(
            height: 25,
            'assets/images/battery.svg',
            color: bottomNavigationBarIndex == 3
                ? AppConstants.blueColor
                : Colors.grey,
          ),
        ),
        label: 'اقتراح منظومة',
      ),
    ];
  }

  List<Widget> screens = [
    PreviousJobsBody(
      token: CacheHelper.getData(key: 'UserToken'),
    ),
    HomePage(),
    ConversationsScreen(),
    SuggestsystemScreen()
  ];
  List<Widget> get listOfIcons {
    return [
      Icon(
        Icons.message,
        size: SizeConfig.screenWidth * .072, // تصغير حجم الأيقونات
        color: bottomNavigationBarIndex == 0
            ? AppConstants.blueColor
            : Colors.black26,
      ),
      Icon(
        FontAwesomeIcons.home,
        size: SizeConfig.screenWidth * .072, // تصغير حجم الأيقونات
        color: bottomNavigationBarIndex == 1
            ? AppConstants.blueColor
            : Colors.black26,
      ),
      Icon(
        FontAwesomeIcons.archive,
        size: SizeConfig.screenWidth * .072, // تصغير حجم الأيقونات
        color: bottomNavigationBarIndex == 2
            ? AppConstants.blueColor
            : Colors.black26,
      ),
      SizedBox(
        width: 25,
        height: 25,
        child: SvgPicture.asset(
          height: 25,
          'assets/images/battery.svg',
          color: bottomNavigationBarIndex == 3
              ? AppConstants.blueColor
              : Colors.grey,
        ),
      ),
    ];
  }

  List<String> listOfStrings = [
    'المحادثات',
    'الرئيسية',
    'الأعمال السابقة',
    'اقتراح منظومة',
  ];
  void changeBottomNavigationBarIndex(int index) {
    emit(homepageInitial());
    bottomNavigationBarIndex = index;
    HapticFeedback.lightImpact();
    emit(ChangeBottomNavigationBarIndex());
  }

  final homeRepo Repo;
  // String groupname = '';
  List<System> proposedSystem = [];

  List<Product> products = [];

  List<Product> panales = [];

  List<Product> batteries = [];

  List<Product> inverters = [];

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
    result.fold((failure) {
      emit(GetProductsFailure(((failure.errorMessege))));
    }, (data) {
      products = data;
      emit(GetProductsSuccess(products));
    });
  }

  Future<void> fetchAllPanales() async {
    emit(GetPanalesLoading());
    var result = await Repo.fetchPanales();
    result.fold((failure) {
      emit(GetPanalesFailure(((failure.errorMessege))));
    }, (data) {
      panales = data;
      emit(GetPanalesSuccess(panales));
    });
  }

  Future<void> fetchAllBAtteries() async {
    emit(GetBatteriesLoading());
    var result = await Repo.fetchbatteries();
    result.fold((failure) {
      emit(GetBatteriesFailure(((failure.errorMessege))));
    }, (data) {
      batteries = data;
      emit(GetBatteriesSuccess(batteries));
    });
  }

  Future<void> fetchAllInverters() async {
    emit(GetInvertersLoading());
    var result = await Repo.fetchInverters();
    result.fold((failure) {
      emit(GetInvertersFailure(((failure.errorMessege))));
    }, (data) {
      inverters = data;
      emit(GetInvertersSuccess(inverters));
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
      CacheHelper.saveData(key: 'UserID', value: userInfo?.id);
      emit(GetUserInfoSuccess(data));
    });
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    var result =
        await Repo.Loguot(token: CacheHelper.getData(key: 'UserToken'));
    result.fold((failure) {
      emit(LogoutFailure(((failure.errorMessege))));
    }, (data) {
      emit(LogoutSuccess((data)));
    });
  }

  List<ProductOrder> currentOrders = [];
  Map<int, int> productQuantities = {};

  void increaseQuantity(int productId) {
    if (productQuantities.containsKey(productId)) {
      productQuantities[productId] = productQuantities[productId]! + 1;
    } else {
      productQuantities[productId] = 1;
    }
    emit(OrderAmountChanged());
  }

  void decreaseQuantity(int productId) {
    if (productQuantities.containsKey(productId) &&
        productQuantities[productId]! > 1) {
      productQuantities[productId] = productQuantities[productId]! - 1;
    } else {
      productQuantities[productId] = 1;
    }
    emit(OrderAmountChanged());
  }

  int getQuantity(int productId) {
    return productQuantities[productId] ?? 1;
  }

  void addProductToOrder(ProductOrder orderItem) {
    currentOrders.add(orderItem);
    emit(OrderUpdatedState(currentOrders));
    print('product added');
    print(currentOrders.length);
  }

  void removeProductFromOrder(int id) {
    currentOrders.removeWhere((item) => item.id == id);
    emit(OrderUpdatedState(currentOrders));
  }

  void submitOrder(Order1 order) async {
    emit(SubmitOrderLoading());
    final result = await Repo.submitOrder(order);
    result.fold(
      (failure) => emit(SubmitOrderFailure(errMessage: failure.errorMessege)),
      (success) => emit(SubmitOrderSuccess(message: success.msg)),
    );
    clearCurrentOrders();
  }

  void clearCurrentOrders() {
    currentOrders.clear();
    emit(homepageOrdersCleared());
  }
}
