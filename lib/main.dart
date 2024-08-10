import 'dart:developer';
import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/app_router.dart';
import 'package:alternative_energy_user_app/core/utils/cache_helper.dart';
import 'package:alternative_energy_user_app/core/utils/dio_helper.dart';
import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/core/utils/size_config.dart';
import 'package:alternative_energy_user_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  DioHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  CacheHelper.init();
  runApp(const UserApp());
}

class UserApp extends StatelessWidget {
  const UserApp({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: TextStyle(color: Colors.grey),
            selectedItemColor: AppConstants.blueColor,
            selectedIconTheme: IconThemeData(size: 30)),
        primaryColor: AppConstants.blueColor,
        colorScheme: ColorScheme.fromSeed(seedColor: AppConstants.blueColor),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppConstants.blueColor,
        ),
        scaffoldBackgroundColor: AppConstants.whiteColor,
        textTheme: GoogleFonts.notoKufiArabicTextTheme(
                Theme.of(context).textTheme.copyWith())
            .apply(
          bodyColor: Colors.black,
        ),
      ),
      routerConfig: AppRouter.router,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}
