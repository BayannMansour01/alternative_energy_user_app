import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/chat_screen.dart';
import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/home_screen.dart';
import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/widgets/chat_user.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/home_page.dart';
import 'package:alternative_energy_user_app/features/login_screen/login_screen.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/presentation/screen/prev_jobs_page.dart';
import 'package:alternative_energy_user_app/features/profile_screen/presentation/screens/profile_screen.dart';
import 'package:alternative_energy_user_app/features/register_screen/register_screen.dart';
import 'package:alternative_energy_user_app/features/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kRegisterView = '/RegisterView';
  static const kLoginView = '/LoginView';
  static const khomeView = '/homeView';
  static const kProfileView = '/ProfileView';

  static const kChatView = '/kChatView';

  static const kChatUserView = '/kChatUserView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => SplashView(),
      ),
      GoRoute(
        path: khomeView,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => RegisterView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => LoginView(),
      ),
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
    ],
  );
}
