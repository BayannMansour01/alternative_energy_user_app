import 'dart:async';
import 'dart:developer';

import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/app_router.dart';
import 'package:alternative_energy_user_app/core/utils/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  @override
  void initState() {
    super.initState();

    _initSlidingAnimation();
    _navigateToHomeView();
    log ('${AppConstants.ip}');
  }

  void _initSlidingAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
        .animate(_controller);
    _controller.forward();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToHomeView() {
    Future.delayed(const Duration(seconds: 6), () async {
      context.pushReplacement(AppRouter.kLoginView);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Image.asset(
            'assets/images/LOGO.png',
            scale: 1.5,
          ),
        ),
      ),
    ));
  }
}
