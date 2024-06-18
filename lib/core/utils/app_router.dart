// <<<<<<< Bayan
import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/chat_screen.dart';
// =======
import 'dart:typed_data';

import 'package:alternative_energy_user_app/core/utils/cache_helper.dart';
// >>>>>>> main
import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/home_screen.dart';
import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/widgets/chat_user.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/home_page.dart';
import 'package:alternative_energy_user_app/features/login_screen/login_screen.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/presentation/screen/prev_jobs_page.dart';
// <<<<<<< Bayan
import 'package:alternative_energy_user_app/features/profile_screen/presentation/screens/profile_screen.dart';
// =======
import 'package:alternative_energy_user_app/features/previuosjobspage/presentation/screen/widgets/prev_jobs_details/prev_jobs_details_body.dart';
import 'package:alternative_energy_user_app/features/register_screen/models/message_model.dart';
// >>>>>>> main
import 'package:alternative_energy_user_app/features/register_screen/register_screen.dart';
import 'package:alternative_energy_user_app/features/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kRegisterView = '/RegisterView';
  static const kLoginView = '/LoginView';
  static const khomeView = '/homeView';
// <<<<<<< Bayan
  static const kProfileView = '/ProfileView';

  static const kChatView = '/kChatView';

  static const kChatUserView = '/kChatUserView';

// =======
 static const kJobListScreen = '/JobListScreen';
 static const kJobDetailsScreen = '/JobDetailsScreen';
 
// >>>>>>> main
  static final router = GoRouter(
    routes: [
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => SplashView(),
      // ),
      GoRoute(
        path:khomeView,
        builder: (context, state) {
          //final token = state.extra as String; // استلم التوكن هنا
          return HomePage( token: CacheHelper.getData(key: 'Token'),); // تمرير التوكن إلى HomePage
        },
      ),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => RegisterView(),
      ),
      GoRoute(
        path:'/', // kLoginView,
        builder: (context, state) => LoginView(),
      ),
// <<<<<<< Bayan
      GoRoute(
        path: kProfileView,
        builder: (context, state) => ProfileView(),
      ),
      GoRoute(
        path: kChatView,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: kChatUserView,
        builder: (context, state) => ChatScreen(user: state.extra as ChatUser),
      ),
// =======
        GoRoute(
        path:kJobListScreen,
         builder: (context, state) {
           // استلم التوكن هنا
          return JobListScreen( token: CacheHelper.getData(key: 'Token'),
          );} // تمرير التوكن إلى JobListScreen
      ),
      //  GoRoute(
      //   path:kJobDetailsScreen, 
      //   builder: (context, state) {
        
      //     return JobDetailsScreen( token: CacheHelper.getData(key: 'Token'), jobId: 1,
      //     );} )

// >>>>>>> main
    ],
  );
}
