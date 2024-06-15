import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class homepageCubit extends Cubit<homepageState> {
  homepageCubit() : super(homepageInitial());
  bool listining = false;

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
}
