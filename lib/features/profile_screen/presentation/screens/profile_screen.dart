// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/func/custom_progress_indicator.dart';
import 'package:alternative_energy_user_app/core/func/custom_snack_bar.dart';
import 'package:alternative_energy_user_app/core/utils/app_router.dart';
import 'package:alternative_energy_user_app/core/utils/cache_helper.dart';
import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/core/utils/size_config.dart';
import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/widgets/chat_user.dart';
import 'package:alternative_energy_user_app/core/utils/api/apis.dart';
import 'package:alternative_energy_user_app/features/homepage/data/repos/home_repo_impl.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:alternative_energy_user_app/features/profile_screen/presentation/cubit/profile_cubit.dart';
import 'package:alternative_energy_user_app/features/register_screen/logout_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../login_screen/login_screen.dart';
import 'widgets/profile_body.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homepageCubit(
        getIt.get<HomeRepoImpl>(),
      )..fetchUserInfo(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "السجل الشخصي",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: profileBody(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            // CustomDialog.showProgressBar(context);
            await APIs.updateActiveStatus(false);
            await APIs.auth.signOut().then(
              (value) async {
                (await LogOutService.logout(
                  token: await CacheHelper.getData(key: 'UserToken'),
                ))
                    .fold(
                  (failure) {
                    CustomSnackBar.showErrorSnackBar(
                      context,
                      message: 'Something Went Wrong, Please Try Again',
                    );
                  },
                  (success) async {
                    await CacheHelper.deletData(key: 'UserToken');
                    context.pushReplacement(AppRouter.kLoginView);
                    //  Navigator.popAndPushNamed(context, LoginView.route);
                  },
                );
              },
            );
          },
          label: const Text(
            'LogOut',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          backgroundColor: Colors.redAccent,
        ),
      ),
    );
  }
}
