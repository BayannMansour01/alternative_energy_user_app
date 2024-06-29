import 'dart:developer';

import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/api/apis.dart';
import 'package:alternative_energy_user_app/core/utils/app_router.dart';
import 'package:alternative_energy_user_app/core/widgets/custom_image.dart';
import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/chat_screen.dart';
import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/widgets/chat_user.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/user_model.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/widgets/custom_drawer_button.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class CustomDrawer {
  static Drawer getCustomDrawer(
    BuildContext context, {
    required GlobalKey<ScaffoldState> scaffoldKey,
    // required PropertiesCubit propertiesCubit,
    required UserModel userModel,
  }) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      width: 250,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
                color: AppConstants.blueColor),
            child: Column(
              children: [
                SizedBox(height: 50),
                Center(
                  // child: Icon(Icons.person_4_sharp),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: CustomImage(
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                      image: 'assets/images/LOGO.png',
                      // backgroundColor: Colors.transparent,
                      // color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    '${userModel.name}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
          SizedBox(height: 30),
          CustomDrawerButton(
            text: 'السجل الشخصي',
            icon: Icons.account_circle,
            onPressed: () {
              context.push(AppRouter.kProfileView);
            },
          ),
          SizedBox(height: 15),
          CustomDrawerButton(
            text: '! اسأل سؤالاً',
            icon: Icons.chat,
            onPressed: () async {
              ChatUser? user = await APIs.getCompany();
              log("user ${user?.id}");
              if (user != null) {
                context.push(
                  AppRouter.kChatUserView,
                  extra: user,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User not found')),
                );
              }
            },
          ),
          SizedBox(height: 15),
          CustomDrawerButton(
            text: 'حجز موعد صيانة',
            fontSize: 18,
            icon: Icons.check_circle,
            onPressed: () {
           context.push(AppRouter.kMaintenanceRequestPage);

            },
          ),
          SizedBox(height: 15),
          const Expanded(child: SizedBox(height: 10)),
          CustomDrawerButton(
            text: 'Logout',
            icon: Icons.logout,
            iconColor: Colors.red,
            onPressed: () async {
              // await propertiesCubit.logOut(context);
            },
          ),
          const SizedBox(height: 20),
          SizedBox(height: 25),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
