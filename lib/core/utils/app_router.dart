import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/chat_screen.dart';

import 'dart:typed_data';

import 'package:alternative_energy_user_app/core/utils/cache_helper.dart';

import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/conversations_screen.dart';
import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/widgets/chat_user.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/home_page.dart';
import 'package:alternative_energy_user_app/features/login_screen/login_screen.dart';
import 'package:alternative_energy_user_app/features/maintainanceRequestScreen/presentation/screens/maintenanceRequestPage.dart';
import 'package:alternative_energy_user_app/features/myOrdersScreen/presentation/screens/all_my_order.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/presentation/screen/prev_jobs_page.dart';

import 'package:alternative_energy_user_app/features/profile_screen/presentation/screens/profile_screen.dart';

import 'package:alternative_energy_user_app/features/previuosjobspage/presentation/screen/widgets/prev_jobs_details_body.dart';

import 'package:alternative_energy_user_app/features/register_screen/register_screen.dart';
import 'package:alternative_energy_user_app/features/splash/splash_view.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/manager/cubit/suggest_system_cubit.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/screens/suggestSystem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kRegisterView = '/RegisterView';
  static const kLoginView = '/LoginView';
  static const khomeView = '/homeView';

  static const kProfileView = '/ProfileView';
  static const kMaintenanceRequestPage = '/MaintenanceRequestPage';
  static const kChatView = '/kChatView';

  static const kChatUserView = '/kChatUserView';
  static const kJobListScreen = '/JobListScreen';
  static const kJobDetailsScreen = '/JobDetailsScreen';
  static const kAllMyOrders = '/kAllMyOrders';

  static const ksuggestSystem = '/kSuggestSystem';

  static final router = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) {
            // if (CacheHelper.getData(key: "Token") != null)
            //   return HomePage();
            // else
            return SplashView();
          }
          // SplashView(),
          ),
      GoRoute(
        path: khomeView,
        builder: (context, state) {
          return HomePage();
        },
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) {
          if (CacheHelper.getData(key: 'UserToken') != null &&
              (DateTime.now().millisecondsSinceEpoch <
                  CacheHelper.getData(key: 'token_expiry'))) {
            return HomePage();
          } else {
            CacheHelper.deletData(key: 'UserToken');
            CacheHelper.deletData(key: 'token_expiry');
            return LoginView();
          }
        },
      ),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => RegisterView(),
      ),
      GoRoute(
        path: kProfileView,
        builder: (context, state) => ProfileView(),
      ),
      GoRoute(
        path: kChatView,
        builder: (context, state) => ConversationsScreen(),
      ),
      GoRoute(
        path: kChatUserView,
        builder: (context, state) => ChatScreen(
          user: state.extra as ChatUser,
        ),
      ),
      GoRoute(
          path: kJobListScreen,
          builder: (context, state) {
            return JobListScreen();
          }),
      GoRoute(
          path: kJobDetailsScreen,
          builder: (context, state) {
            return JobDetailsScreen(
              token: CacheHelper.getData(key: 'UserToken'),
              jobId: state.extra as int,
            );
          }),
      GoRoute(
        path: kAllMyOrders,
        builder: (context, state) => AllMyOrderPage(),
      ),
      GoRoute(
        path: kMaintenanceRequestPage,
        builder: (context, state) => MaintenanceRequestPage(),
      ),
      GoRoute(
        path: ksuggestSystem,
        builder: (context, state) => SuggestSystem(),
      ),
    ],
  );
}
