import 'package:alternative_energy_user_app/core/constants.dart';
// <<<<<<< Bayan
import 'package:alternative_energy_user_app/core/func/custom_progress_indicator.dart';
import 'package:alternative_energy_user_app/core/func/custom_snack_bar.dart';
import 'package:alternative_energy_user_app/core/utils/size_config.dart';
import 'package:alternative_energy_user_app/core/widgets/custom_button.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/widgets/custom_drawer.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/widgets/proposedSystem.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import 'product_item.dart';

class HomePageBody extends StatelessWidget {
  final String token;
  const HomePageBody({super.key, required this.token});
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<homepageCubit>(context);
    return BlocConsumer<homepageCubit, homepageState>(
      listener: (context, state) {
        cubit.listining = true;
// <<<<<<< Bayan
        if ((state is GetProposedSystemLoading ||
                state is GetProductsLoading) &&
            !CustomProgressIndicator.isOpen) {
          CustomProgressIndicator.showProgressIndicator(context);
        } else {
          if (CustomProgressIndicator.isOpen) {
            context.pop();
          }
          if (state is GetProposedSystemFailure) {
            CustomSnackBar.showErrorSnackBar(context,
                message: state.errMessage);
          }
        }
// =======
       
// >>>>>>> main
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "الصفحة الرئيسية",
              style: TextStyle(color: Colors.white),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavigationBarItems,
            onTap: (index) {
               cubit.changeBottomNavigationBarIndex(index);
              if (index == 1) {
                GoRouter.of(context).push(
                  AppRouter.kJobListScreen,
               
                );}
            },
            currentIndex: cubit.bottomNavigationBarIndex,
          ),
          drawer: cubit.userInfo != null
              ? CustomDrawer.getCustomDrawer(
                  userModel: cubit.userInfo!,
                  context,
                  scaffoldKey: cubit.scaffoldKey,
                )
              : null,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250,
                  child: ScrollSnapList(
                    curve: Curves.ease,
                    initialIndex: 2.0,
                    allowAnotherDirection: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ReadyMadeSystemItem(
                          context, cubit.proposedSystem[index]);
                    },
                    itemCount: cubit.proposedSystem.length,
                    itemSize: 200,
                    onItemFocus: (p0) {},
                    dynamicItemSize: true,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  child: Text(
                    "المنتجات الشائعة",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CategoryItem(
                      icon: Icons.all_out_sharp,
                      text: "الكل",
                    ),
                    // SizedBox(width: 5),
                    CategoryItem(
                      icon: Icons.admin_panel_settings_sharp,
                      text: "الألواح",
                    ),
                    // SizedBox(width: 5),
                    CategoryItem(
                      icon: Icons.battery_5_bar,
                      text: "البطاريات",
                    ),
                    // SizedBox(width: 5),
                    CategoryItem(
                      icon: Icons.device_hub,
                      text: "الإنفيرترات",
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Expanded(
                  flex: 2,
                  child: GridView.builder(
                    itemCount: cubit.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      return ProductItem(
                        product: cubit.products[index],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String text;
  final IconData icon;
  const CategoryItem({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CircleAvatar(
              child: Icon(
                icon,
                color: Colors.white,
              ),
              backgroundColor: AppConstants.blueColor,
              radius: 30,
            ),
          ),
          Text(
            "$text",
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }
}
