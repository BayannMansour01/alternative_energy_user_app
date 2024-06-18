import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/app_router.dart';
import 'package:alternative_energy_user_app/core/widgets/custom_text_field.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/home_page.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/widgets/proposedSystem.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/presentation/screen/prev_jobs_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class HomePageBody extends StatelessWidget {
  final String token;
  const HomePageBody({super.key, required this.token});
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<homepageCubit>(context);
    return BlocConsumer<homepageCubit, homepageState>(
      listener: (context, state) {
        cubit.listining = true;
       
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
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  child: ScrollSnapList(
                    curve: Curves.ease,
                    initialIndex: 2.0,
                    allowAnotherDirection: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ReadyMadeSystemItem(context);
                    },
                    itemCount: 10,
                    itemSize: 200,
                    onItemFocus: (p0) {},
                    dynamicItemSize: true,
                  ),
                ),
                const CustomTextField(
                  // iconData: Icons.search,
                  prefixIcon: Icon(Icons.search),
                  //    labelText: 'search',
                  hintText: 'Search',
                  width: double.infinity,
                ),
                Expanded(
                  flex: 2,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppConstants.orangeColor),
                        width: 150, // Set the width of each item
                        margin:
                            EdgeInsets.all(8), // Add some margin for separation
                        // color: AppConstants
                        //     .orangeColor, // Just for demonstration, you can customize as needed
                        child: const Center(
                          child: Text(
                            'item',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
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
