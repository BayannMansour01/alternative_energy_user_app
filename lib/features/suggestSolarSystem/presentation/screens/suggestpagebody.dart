import 'dart:developer';

import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/core/utils/size_config.dart';
import 'package:alternative_energy_user_app/core/widgets/custom_text_field.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/product_model.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/selected_device_model.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/solarSystemBody.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/suggestedProducts.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/repo/suggestSystem_repo_impl.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/manager/cubit/suggest_system_cubit.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/screens/suggestedProductScreens/suggestedProducts.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return '$formattedHour:00$period';
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
        return SizedBox(
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
                    final device = cubit.devicesFromServer[index];
                    final isSelected =
                        cubit.selectedDevices.contains(device.id);

                    return SizedBox(
                      width: 230,
                      child: InkWell(
                        onTap: () {},
                        child: Stack(
                          children: [
                            Card(
                              color: isSelected
                                  ? AppConstants.blueColor
                                  : const Color.fromRGBO(255, 255, 255, 1),
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
                                            device.image,
                                        fit: BoxFit.cover,
                                        height: SizeConfig.screenHeight * .15,
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
                                      values: cubit.hoursRange,
                                      min: 0,
                                      max: 24,
                                      divisions: 24,
                                      labels: RangeLabels(
                                        _formatTimeLabel(
                                            cubit.hoursRange.start),
                                        _formatTimeLabel(cubit.hoursRange.end),
                                      ),
                                      activeColor: AppConstants.orangeColor,
                                      onChanged: (RangeValues values) {
                                        cubit.updateHoursRange(values);
                                      },
                                    ),
                                    const Text('ادخل استطاعة الجهاز ',
                                        style: TextStyle(color: Colors.grey)),
                                    Slider(
                                      value: cubit.currentValues[device.id] ??
                                          ((device.minCurrent.toDouble() +
                                                  device.maxCurrent
                                                      .toDouble()) /
                                              2),
                                      min: device.minCurrent.toDouble(),
                                      max: device.maxCurrent.toDouble(),
                                      divisions: 100,
                                      label: cubit.currentValues[device.id]
                                              ?.round()
                                              .toString() ??
                                          '',
                                      activeColor: Colors.orange,
                                      onChanged: (double value) {
                                        cubit.updateCurrentValue(
                                            device.id, value);
                                        cubit.updatePowerRange(RangeValues(
                                            device.minCurrent.toDouble(),
                                            value));
                                      },
                                    ),
                                    Container(
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              cubit.decreaseQuantity(device.id);
                                            },
                                            icon: Icon(Icons.remove),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                '${cubit.getQuantity(device.id)}'),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              cubit.increaseQuantity(device.id);
                                            },
                                            icon: Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        cubit.toggleDeviceSelection(device.id);
                                        cubit.selectDevices(SelectedDevice(
                                          id: device.id,
                                          name: device.name,
                                          from: _formatTimeLabel(
                                              cubit.hoursRange.start),
                                          num: cubit.getQuantity(device.id),
                                          to: _formatTimeLabel(
                                              cubit.hoursRange.end),
                                        ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            AppConstants.orangeColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text('اختر الجهاز'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Icon(
                                  Icons.check_circle,
                                  color: AppConstants.orangeColor,
                                  size: 24,
                                ),
                              ),
                          ],
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
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppConstants.orangeColor, // لون النص
                      ),
                      onPressed: () {
                        cubit.selectedDevicesFromListToMap(
                            cubit.selectedDevicesList);
                        cubit.suggestSystem(cubit.selectedDeviceMap);
                        
                        log('selectedDeviceMap ${cubit.selectedDeviceMap}');
                        log('suggestSystem ${cubit.suggestSystem(cubit.selectedDeviceMap)}');
                     
                       cubit.calculateSystem(cubit.suggestSystem(cubit.selectedDeviceMap) );
                        cubit.clearSelections();
 if (state is CalculateSystemSuccessState){
 Suggestedproducts product =state.response;
   Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => SuggestedproductsScreen(product: product,)),

                        );

 }
                     
                      },
                      child: const Text('عرض المنظومة المناسبة '),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
