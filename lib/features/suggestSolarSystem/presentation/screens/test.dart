import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/suggestedProducts.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/repo/suggestSystem_repo_impl.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/manager/cubit/suggest_system_cubit.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/screens/detailes_suggest_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuggestedproductsScreen extends StatelessWidget {
  final Suggestedproducts product;

  const SuggestedproductsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SuggestSystemCubit(getIt.get<SuggestSystemRepoImpl>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'المنظومة المقترحة',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppConstants.blueColor,
        ),
        body: BlocConsumer<SuggestSystemCubit, SuggestSystemState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is SuggestSystemLoading) {
              return Center(child: const CircularProgressIndicator());
            } else {
              final tubularBatteryProduct = Suggestedproducts(
                panels: product.panels,
                batteries: product.batteries,
                inverter: product.inverter,
                totalCost: product.totalCost,
                numberOfPanels: product.numberOfPanels,
                numberOfTubularBatteries: product.numberOfTubularBatteries,
                numberOfLithiumBatteries: 0,
              );

              final lithiumBatteryProduct = Suggestedproducts(
                panels: product.panels,
                batteries: product.batteries,
                inverter: product.inverter,
                totalCost: product.totalCost,
                numberOfPanels: product.numberOfPanels,
                numberOfTubularBatteries: 0,
                numberOfLithiumBatteries: product.numberOfLithiumBatteries,
              );

              return ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  // الرسالة التوضيحية
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'يمكنك اختيار إحدى المنظومتين حسب ما يناسبك. كل منظومة تختلف في نوع البطاريات المستخدمة (أنبوبية أو ليثيوم).',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10), // مسافة إضافية بين الرسالة والقائمة
                  buildSystemCard(
                      context,
                      tubularBatteryProduct,
                      product.numberOfTubularBatteries,
                      'المنظومة 1 - بطارية أنبوبية'),
                  SizedBox(height: 20),
                  buildSystemCard(
                      context,
                      lithiumBatteryProduct,
                      product.numberOfLithiumBatteries,
                      'المنظومة 2 - بطارية ليثيوم'),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildSystemCard(BuildContext context, Suggestedproducts product,
      int numberOfBatteries, String systemName) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              systemName,
              style: TextStyle(
                color: AppConstants.orangeColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            buildProductDetail('الواح شمسية', 'assets/images/solar-panel.png',
                product.numberOfPanels),
            SizedBox(height: 10),
            buildProductDetail(
                'بطاريات', 'assets/images/accumulator.png', numberOfBatteries),
            SizedBox(height: 10),
            buildProductDetail('انفرتر', 'assets/images/solar-inverter.png', 1),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'السعر الكلي: ${product.totalCost}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppConstants.orangeColor,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SuggestedSystemDetailsScreen(
                        product: product,
                      ),
                    ),
                  );
                  // التعامل مع إرسال المنظومة المحددة
                  // هنا يتم إرسال الـ product المختار
                  print('تم اختيار $systemName');
                },
                child: Text('عرض تفاصيل هذه المنظومة'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductDetail(String title, String imagePath, int quantity) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 50,
          height: 50,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppConstants.orangeColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('العدد: $quantity',
                style: TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ],
    );
  }
}
