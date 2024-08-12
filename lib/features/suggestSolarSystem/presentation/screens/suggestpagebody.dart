import 'dart:developer';

import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/core/utils/size_config.dart';
import 'package:alternative_energy_user_app/core/widgets/custom_text_field.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/repo/suggestSystem_repo_impl.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/manager/cubit/suggest_system_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_slider/input_slider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class DevicesList extends StatelessWidget {
  DevicesList({super.key});
  String _formatTimeLabel(double value) {
    final hour =
        value.toInt(); // تأكد من أن القيمة يتم تحويلها بشكل صحيح إلى ساعة
    final isAM = hour < 12 || hour == 24; // التحقق من الفترة AM أو PM
    final formattedHour =
        hour == 0 || hour == 24 ? 12 : (hour > 12 ? hour - 12 : hour);
    final period = isAM ? 'AM' : 'PM';
    return '$formattedHour:00 $period';
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SuggestSystemCubit>(context);
    log('${cubit.devicesFromServer.length}');
    RangeValues hoursRange = cubit.hoursRange;
    RangeValues powerRange = cubit.powerRange;
    return BlocConsumer<SuggestSystemCubit, SuggestSystemState>(
      listener: (context, state) {
        if (state is SuggestSystemUpdatedHoursRange) {
          hoursRange = state.hoursRange;
        }
        if (state is SuggestSystemUpdatedPowerRange) {
          powerRange = state.powerRange;
        }
        if (state is getDvicessSuccessState) {
          log('getDvicessSuccessState ${state.devices.length}');
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: SizedBox(
            height: SizeConfig.screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    textAlign: TextAlign.right,
                    'اختر الأجهزة المراد تشغيلها : ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * .6,
                  child: ScrollSnapList(
                    curve: Curves.ease,
                    initialIndex: 2.0,
                    allowAnotherDirection: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 230,
                        // height: 500,
                        child: InkWell(
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => SystemDetailsPage(
                            //       system: proposedSystem,
                            //     ),
                            //   ),
                            // );
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 12,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Image.network(
                                      'http://${AppConstants.ip}:8000/' +
                                          cubit.devicesFromServer[index].image,
                                      fit: BoxFit.cover,
                                      // width: 100,
                                      height: SizeConfig.screenHeight * .2,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'ادخل ساعات التشغيل',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                  RangeSlider(
                                    values: hoursRange,
                                    min: 0,
                                    max: 24,
                                    divisions: 24,
                                    labels: RangeLabels(
                                      _formatTimeLabel(hoursRange.start),
                                      _formatTimeLabel(hoursRange.end),
                                    ),
                                    activeColor: AppConstants.orangeColor,
                                    onChanged: (RangeValues values) {
                                      cubit.updateHoursRange(values);
                                    },
                                  ), // const SizedBox(height: 5),

                                  const Text('ادخل استطاعة الجهاز ',
                                      style: TextStyle(color: Colors.grey)),
                                  Slider(
                                    value: powerRange.end,
                                    min: 0,
                                    max: 10000,
                                    divisions: 100,
                                    label: powerRange.end.round().toString(),
                                    activeColor: AppConstants.orangeColor,
                                    onChanged: (double value) {
                                      cubit.updatePowerRange(
                                          RangeValues(powerRange.start, value));
                                    },
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Add the logic to select the device here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: AppConstants
                                          .orangeColor, // لون خلفية الزر
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text('اختر الجهاز'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: cubit.devicesFromServer.length,
                    itemSize: 230,
                    onItemFocus: (p0) {},
                    dynamicItemSize: true,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppConstants.orangeColor, // لون النص
                      ),
                      onPressed: () {},
                      child: const Text('إرسال الطلب'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// class MyCustomWidgetView extends StatelessWidget {
//   final List<int> data = List<int>.generate(12, (index) => index);
//   final PageController _pageController = PageController(
//       viewportFraction: 0.8); // لجعل العناصر بجانب بعضها مع وجود الفراغات
//   // int _currentPage = 0;

//   @override
//   Widget build(BuildContext context) {
//     final cubit = BlocProvider.of<SuggestSystemCubit>(context);

//     return BlocConsumer<SuggestSystemCubit, SuggestSystemState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         // double _page = 10;
//         if (state is SuggestSystemUpdatedpage) {
//           // _page = state.page;
//         }
//         RangeValues hoursRange = RangeValues(1, 10);
//         RangeValues powerRange = RangeValues(0, 200);
//         if (state is SuggestSystemUpdatedHoursRange) {
//           hoursRange = state.hoursRange;
//         }
//         if (state is SuggestSystemUpdatedPowerRange) {
//           powerRange = state.powerRange;
//         }

//         return Scaffold(
//           backgroundColor: Colors.grey[200],
//           body: SingleChildScrollView(
//             child: SizedBox(
//               height: SizeConfig.screenHeight,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: SizeConfig.screenHeight * .6,
//                     child: PageView.builder(
//                       controller: _pageController,
//                       itemCount: data.length,
//                       onPageChanged: (index) {
//                         cubit.changepage(index);
//                       },
//                       itemBuilder: (context, index) {
//                         log('${cubit.indexx}');
//                         log('${index}');
//                         double scale = cubit.indexx == index ? 1.0 : 0.8;
//                         return Transform.scale(
//                           scale: scale,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Card(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Container(
//                                 padding:
//                                     EdgeInsets.all(8), // تقليل التباعد الداخلي
//                                 width: 300, // تعديل عرض البطاقة
//                                 height: SizeConfig.screenHeight *
//                                     .5, // تعديل ارتفاع البطاقة
//                                 decoration: BoxDecoration(
//                                   color: Colors.white, // لون خلفية البطاقة
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Center(
//                                       child: Image.asset(
//                                         'assets/images/folders.png',
//                                         width: 100,
//                                         height: SizeConfig.screenHeight * .2,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 10),
//                                     const Text(
//                                       'ادخل ساعات التشغيل',
//                                       style: TextStyle(
//                                           color: Colors.grey, fontSize: 16),
//                                     ),
//                                     const SizedBox(
//                                         width:
//                                             16), // Space between text and TextField
//                                     Expanded(
//                                       child: TextField(
//                                         onChanged: (value) {
//                                           print(value);
//                                         },
//                                         decoration: InputDecoration(
//                                           hintText: 'عدد الساعات',
//                                           hintStyle: TextStyle(
//                                               color: Colors.grey.shade400),
//                                           contentPadding:
//                                               const EdgeInsets.symmetric(
//                                                   vertical: 10, horizontal: 15),
//                                           // border: OutlineInputBorder(
//                                           //   borderRadius:
//                                           //       BorderRadius.circular(12),
//                                           //   borderSide: BorderSide(
//                                           //       color:
//                                           //           Colors.grey.shade300),
//                                           // ),
//                                           // // focusedBorder: OutlineInputBorder(
//                                           // //   borderRadius:
//                                           // //       BorderRadius.circular(12),
//                                           // //   borderSide: BorderSide(
//                                           // //       color:
//                                           // //           AppConstants.blueColor),
//                                           // ),
//                                           // filled: true,
//                                           // fillColor: Colors.grey.shade100,
//                                         ),
//                                       ),
//                                     ),

//                                     // const SizedBox(height: 10),
//                                     const Text('ادخل استطاعة الجهاز ',
//                                         style: TextStyle(color: Colors.grey)),
//                                     RangeSlider(
//                                       values: powerRange,
//                                       min: 0,
//                                       max: 300,
//                                       divisions: 30,
//                                       labels: RangeLabels(
//                                         powerRange.start.round().toString(),
//                                         powerRange.end.round().toString(),
//                                       ),
//                                       activeColor: AppConstants.orangeColor,
//                                       onChanged: (RangeValues values) {
//                                         context
//                                             .read<SuggestSystemCubit>()
//                                             .updatePowerRange(values);
//                                       },
//                                     ),
//                                     // const SizedBox(
//                                     //   height: 10,
//                                     // ),
//                                     ElevatedButton(
//                                       onPressed: () {
//                                         // Add the logic to select the device here
//                                         print(
//                                             'Device selected with hours range: $hoursRange and power range: $powerRange');
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         foregroundColor: Colors.white,
//                                         backgroundColor: AppConstants
//                                             .orangeColor, // لون خلفية الزر
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(12),
//                                         ),
//                                       ),
//                                       child: Text('اختر الجهاز'),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   // SizedBox(
//                   //   height: SizeConfig.screenHeight * .4,
//                   // ),
//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                           backgroundColor: AppConstants.orangeColor, // لون النص
//                         ),
//                         onPressed: () {},
//                         child: const Text('إرسال الطلب'),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
