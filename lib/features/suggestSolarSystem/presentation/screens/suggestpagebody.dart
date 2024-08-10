import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/manager/cubit/suggest_system_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SuggestSystemCubit(),
      child: MyCustomWidgetView(),
    );
  }
}

class MyCustomWidgetView extends StatefulWidget {
  @override
  _MyCustomWidgetViewState createState() => _MyCustomWidgetViewState();
}

class _MyCustomWidgetViewState extends State<MyCustomWidgetView> {
  final List<int> data = List<int>.generate(12, (index) => index);
  final PageController _pageController = PageController(viewportFraction: 0.8); // لجعل العناصر بجانب بعضها مع وجود الفراغات
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuggestSystemCubit, SuggestSystemState>(
      builder: (context, state) {
        double _page = 10;
        if (state is SuggestSystemUpdatedpage) {
          _page = state.page;
        }

        RangeValues hoursRange = RangeValues(1, 10);
        RangeValues powerRange = RangeValues(50, 200);

        if (state is SuggestSystemUpdatedHoursRange) {
          hoursRange = state.hoursRange;
        }

        if (state is SuggestSystemUpdatedPowerRange) {
          powerRange = state.powerRange;
        }

        return Scaffold(
          backgroundColor: Colors.grey[200],
          body: Center(
            child: Column(
              children: [
                Container(
                  height: 400,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: data.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index; // تحديث الصفحة الحالية
                      });
                    },
                    itemBuilder: (context, index) {
                      double scale = _currentPage == index ? 1.0 : 0.8;
                      return Transform.scale(
                        scale: scale,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(8), // تقليل التباعد الداخلي
                              width: 300, // تعديل عرض البطاقة
                              height: 300, // تعديل ارتفاع البطاقة
                              decoration: BoxDecoration(
                                color: Colors.white, // لون خلفية البطاقة
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/folders.png',
                                    width: 100,
                                    height: 100,
                                  ),
                                  SizedBox(height: 10),
                                  Text('ادخل ساعات التشغيل',
                                      style: TextStyle(color: Colors.grey)),
                                  RangeSlider(
                                    values: hoursRange,
                                    min: 0,
                                    max: 24,
                                    divisions: 24,
                                    labels: RangeLabels(
                                      hoursRange.start.round().toString(),
                                      hoursRange.end.round().toString(),
                                    ),
                                    activeColor: AppConstants.orangeColor,
                                    onChanged: (RangeValues values) {
                                      context
                                          .read<SuggestSystemCubit>()
                                          .updateHoursRange(values);
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  Text('ادخل استطاعة الجهاز ',
                                      style: TextStyle(color: Colors.grey)),
                                  RangeSlider(
                                    values: powerRange,
                                    min: 0,
                                    max: 300,
                                    divisions: 30,
                                    labels: RangeLabels(
                                      powerRange.start.round().toString(),
                                      powerRange.end.round().toString(),
                                    ),
                                    activeColor: AppConstants.orangeColor,
                                    onChanged: (RangeValues values) {
                                      context
                                          .read<SuggestSystemCubit>()
                                          .updatePowerRange(values);
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Add the logic to select the device here
                                      print(
                                          'Device selected with hours range: $hoursRange and power range: $powerRange');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          AppConstants.orangeColor, // لون خلفية الزر
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
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
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
        );
      },
    );
  }
}
