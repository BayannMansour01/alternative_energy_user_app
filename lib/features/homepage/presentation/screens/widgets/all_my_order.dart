import 'dart:developer';

import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/features/homepage/data/repos/home_repo_impl.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/widgets/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllMyOrderPage extends StatelessWidget {
  const AllMyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          homepageCubit(getIt.get<HomeRepoImpl>())..fetchAllmyOrders(),
      child: BlocConsumer<homepageCubit, homepageState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = BlocProvider.of<homepageCubit>(context);

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "طلباتي",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: state is getMyAllOrederssSuccessState
                ? ListView.builder(
                    itemCount: cubit.MyOrders.length,
                    itemBuilder: (context, index) {
                      final orderDetails = cubit.MyOrders[index];

                      return Card(
                        color: Color.fromARGB(255, 232, 243, 248),
                        margin: EdgeInsets.all(10.0),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    orderDetails.typeId == '1'
                                        ? 'صيانة  '
                                        : "تركيب  ",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: AppConstants.blueColor),
                                  ),
                                  Text(" الموقع ${orderDetails.location} "),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              CustomStepper(
                                  cubit,
                                  orderDetails.state == "waiting"
                                      ? 0
                                      : orderDetails.state == "Detect"
                                          ? 1
                                          : orderDetails.state == "Execute"
                                              ? 2
                                              : orderDetails.state == "Done"
                                                  ? 3
                                                  : 0),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: AppConstants.blueColor,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
