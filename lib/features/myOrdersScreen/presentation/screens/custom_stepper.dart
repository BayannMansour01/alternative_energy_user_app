import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:alternative_energy_user_app/features/myOrdersScreen/presentation/manager/cubit/my_orders_cubit.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomStepper extends StatelessWidget {
  MyOrdersCubit cubit;
  int statusID;
  CustomStepper(this.cubit, this.statusID, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyOrdersCubit, MyOrdersState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return EasyStepper(
          lineStyle: LineStyle(
            lineLength: 80,
            lineSpace: 0,
            lineType: LineType.normal,
            defaultLineColor: Colors.white,
            finishedLineColor: Colors.orange,
          ),
          activeStep: statusID,
          activeStepTextColor: Colors.black87,
          finishedStepTextColor: Colors.black87,
          internalPadding: 0,
          showLoadingAnimation: false,
          stepRadius: 8,
          showStepBorder: false,
          steps: [
            EasyStep(
              customStep: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: statusID >= 0 ? Colors.orange : Colors.white,
                ),
              ),
              title: 'قيد الانتظار',
            ),
            EasyStep(
              customStep: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: statusID >= 1 ? Colors.orange : Colors.white,
                ),
              ),
              title: 'قيد التحقق',
              topTitle: true,
            ),
            EasyStep(
              customStep: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: statusID >= 2 ? Colors.orange : Colors.white,
                ),
              ),
              title: 'قيد التنفيذ',
            ),
            // EasyStep(
            //   customStep: CircleAvatar(
            //     radius: 8,
            //     backgroundColor: Colors.white,
            //     child: CircleAvatar(
            //       radius: 7,
            //       backgroundColor: activeStep >= 3 ? Colors.orange : Colors.white,
            //     ),
            //   ),
            //   title: 'تم التنفيذ',
            //   topTitle: true,
            // ),
            EasyStep(
              customStep: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: statusID >= 3 ? Colors.orange : Colors.white,
                ),
              ),
              topTitle: true,
              title: 'تم الإنجاز',
            ),
          ],
          onStepReached: (index) {
            return cubit.changeActiveStepper(index);
          },
        );
      },
    );
  }
}
