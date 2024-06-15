import 'dart:async';
import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/app_router.dart';
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
  // late final AnimationController controller1;
  // late final Animation<double> animation1;

  // late final AnimationController controller2;
  // late final Animation<double> animation2;

  // void navigate() {
  //   Timer(const Duration(seconds: 3), () async {
  //     // final String? token = await CacheHelper.getData(key: 'Token');
  //     // if (token == null) {
  //     //   context.pushReplacement(AppRouter.kLoginView);
  //     // } else {
  //     //   context.pushReplacement(AppRouter.kGroupsView, extra: token);
  //     // }
  //     context.push(AppRouter.khomeView);
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   controller1 =
  //       AnimationController(vsync: this, duration: const Duration(seconds: 1));
  //   animation1 = Tween<double>(
  //     begin: .0,
  //     end: .5,
  //   ).animate(CurvedAnimation(parent: controller1, curve: Curves.easeInOut))
  //     ..addListener(() {
  //       setState(() {});
  //     })
  //     ..addStatusListener((status) {
  //       if (status == AnimationStatus.completed) {
  //         controller1.reverse();
  //         controller2.forward();
  //       } else if (status == AnimationStatus.dismissed) {
  //         controller1.forward();
  //       }
  //     });

  //   controller2 =
  //       AnimationController(vsync: this, duration: const Duration(seconds: 1));
  //   animation2 = Tween<double>(begin: .0, end: .5)
  //       .animate(CurvedAnimation(parent: controller2, curve: Curves.easeInOut))
  //     ..addListener(() {
  //       setState(() {});
  //     })
  //     ..addStatusListener((status) {
  //       if (status == AnimationStatus.completed) {
  //         controller2.reverse();
  //       } else if (status == AnimationStatus.dismissed) {
  //         controller2.forward();
  //       }
  //     });

  //   controller1.forward();
  //   navigate();
  // }

  // @override

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _initSlidingAnimation();
    _navigateToHomeView();
  }

  void _initSlidingAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )
        // ..repeat(
        //     reverse: true,
        //   )
        ;
    _offsetAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
        .animate(_controller);
    _controller.forward();
  }

  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _navigateToHomeView() {
    Future.delayed(const Duration(seconds: 6), () async {
      // SystemChrome.setSystemUIOverlayStyle(
      //   const SystemUiOverlayStyle(
      //       systemNavigationBarColor: Colors.black,
      //       statusBarColor: Colors.black,
      //       ),
      // );
      // if (FirebaseAPIs.auth.currentUser != null &&
      //     CacheHelper.getData(key: 'Token') != null) {
      //   log('\n User : ${FirebaseAuth.instance.currentUser}');
      //   (await GetMyInformationService.getMyInfo(
      //           token: CacheHelper.getData(key: 'Token')))
      //       .fold(
      //     (failure) {
      //       // CustomeSnackBar.showErrorSnackBar(context,
      //       //     msg: failure.errorMessege);
      //       Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) {
      //             return const LoginView();
      //           },
      //         ),
      //       );
      //     },
      //     (userModel) {
      //       Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) {
      //             return PropertiesView(userModel: userModel);
      //           },
      //         ),
      //       );
      //     },
      //   );
      // } else {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) {
      //         return const LoginView();
      //       },
      //     ),
      //   );
      // }
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
            'assets/images/LOGO.jpg',
            scale: 3,
          ),
        ),
      ),
    ));
  }
}

class MyPainter extends CustomPainter {
  final double radius_1;
  final double radius_2;

  MyPainter(this.radius_1, this.radius_2);

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle1 = Paint()..color = AppConstants.gradient1;

    Paint circle2 = Paint()..color = AppConstants.gradient2;

    canvas.drawCircle(Offset(size.width * .5, size.height * .5),
        size.width * radius_1, circle1);

    canvas.drawCircle(Offset(size.width * .5, size.height * .5),
        size.width * radius_2, circle2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
