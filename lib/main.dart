import 'dart:developer';
import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/app_router.dart';
import 'package:alternative_energy_user_app/core/utils/cache_helper.dart';
import 'package:alternative_energy_user_app/core/utils/dio_helper.dart';
import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/core/utils/size_config.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/repos/previous_jobs_repo_impl.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/presentation/manager/previous_jobs_cubit.dart';
import 'package:alternative_energy_user_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';

late Size mq;

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

// _initializeFirebase() async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   var result = await FlutterNotificationChannel().registerNotificationChannel(
//       description: 'For Showing Message Notification',
//       id: 'chats',
//       importance: NotificationImportance.IMPORTANCE_HIGH,
//       name: 'Chats');
//   log('\nNotification Channel Result: $result');
// }

class UserApp extends StatelessWidget {
  const UserApp({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: AppConstants.blueColor,
            selectedIconTheme: IconThemeData(size: 30)),
        primaryColor: AppConstants.blueColor,
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
    );
  }
}
