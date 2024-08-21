import 'dart:developer';

import 'package:alternative_energy_user_app/core/utils/app_router.dart';
import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/order_model.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/repo/suggestSystem_repo_impl.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/manager/cubit/suggest_system_cubit.dart';
import 'package:flutter/material.dart';
import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/suggestedProducts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SuggestedSystemDetailsScreen extends StatelessWidget {
  final Suggestedproducts product;

  const SuggestedSystemDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SuggestSystemCubit(getIt.get<SuggestSystemRepoImpl>()),
      child: BlocConsumer<SuggestSystemCubit, SuggestSystemState>(
        listener: (context, state) {
          if (state is SubmitOrderSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم طلب المنظومة بنجاح!')),
            );
            context.push(AppRouter.khomeView);
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<SuggestSystemCubit>(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                product.numberOfLithiumBatteries > 0
                    ? 'المنظومة 2 - بطارية ليثيوم'
                    : 'المنظومة 2 - بطارية أنبوبية',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: AppConstants.blueColor,
            ),
            body: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // عرض تفاصيل الألواح الشمسية
                buildProductCard(context, product.panels.details, 'ألواح شمسية',
                    quantity: product.numberOfPanels),
                SizedBox(height: 20),
                // عرض تفاصيل البطاريات (أنبوبية أو ليثيوم بناءً على العدد)
                if (product.numberOfTubularBatteries > 0)
                  buildProductCard(
                      context, product.batteries.tubular, 'بطارية أنبوبية',
                      quantity: product.numberOfTubularBatteries),
                if (product.numberOfLithiumBatteries > 0)
                  buildProductCard(
                      context, product.batteries.lithium, 'بطارية ليثيوم',
                      quantity: product.numberOfLithiumBatteries),
                SizedBox(height: 20),
                // عرض تفاصيل الإنفرتر
                buildProductCard(context, product.inverter.details, 'انفرتر'),
                Divider(),
                // عرض السعر الكلي
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'السعر الكلي: ${product.totalCost} ل.س',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // زر شراء
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppConstants.orangeColor,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return _LocationDialog(
                            onConfirm: (location) {
                              final orderItems = [
                                ProductOrder(
                                  id: product.panels.details.id,
                                  amount: product.numberOfPanels,
                                  name: product.panels.details.name,
                                  imageUrl: product.panels.details.image,
                                  price: product.panels.details.price,
                                ),
                                if (product.numberOfTubularBatteries > 0)
                                  ProductOrder(
                                    id: product.batteries.tubular.id,
                                    amount: product.numberOfTubularBatteries,
                                    name: product.batteries.tubular.name,
                                    imageUrl: product.batteries.tubular.image,
                                    price: product.batteries.tubular.price,
                                  ),
                                if (product.numberOfLithiumBatteries > 0)
                                  ProductOrder(
                                    id: product.batteries.lithium.id,
                                    amount: product.numberOfLithiumBatteries,
                                    name: product.batteries.lithium.name,
                                    imageUrl: product.batteries.lithium.image,
                                    price: product.batteries.lithium.price,
                                  ),
                                ProductOrder(
                                  id: product.inverter.details.id,
                                  amount: 1,
                                  name: product.inverter.details.name,
                                  imageUrl: product.inverter.details.image,
                                  price: product.inverter.details.price,
                                ),
                              ];

                              final order = Order1(
                                typeId: 2,
                                location: location,
                                products: orderItems,
                              );
                              log('${order.products[0].id}');
                              cubit.submitOrder(order);
                            },
                          );
                        },
                      );
                    },
                    child: Text('طلب هذه المنظومة'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // بناء بطاقة لعرض تفاصيل المنتج مع معلومات إضافية
  Widget buildProductCard(
      BuildContext context, ProductDetails product, String productName,
      {int? quantity}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppConstants.orangeColor,
              ),
            ),
            SizedBox(height: 10),
            Image.network(
              'http://${AppConstants.ip}:8000/${product.image}',
              height: 150,
            ),
            SizedBox(height: 10),
            Text(
              product.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              product.disc,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'السعر: ${product.price} ل.س',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // إضافة معلومات إضافية مثل الفولتية والقدرة
            if (product.panelCapacity != null)
              Text(
                'قدرة اللوح: ${product.panelCapacity} وات',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            if (product.inverterWatt != null)
              Text(
                'قدرة الانفرتر: ${product.inverterWatt} وات',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            if (product.inverterStartWatt != null)
              Text(
                'القدرة الابتدائية للانفرتر: ${product.inverterStartWatt} وات',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            if (product.inverterVolt != null)
              Text(
                'فولتية الانفرتر: ${product.inverterVolt} فولت',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            if (product.batteryVolt != null)
              Text(
                'فولتية البطارية: ${product.batteryVolt} فولت',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            if (product.batteryAmper != null)
              Text(
                'سعة البطارية: ${product.batteryAmper} أمبير',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            // إضافة معلومات عدد الألواح والبطاريات
            if (quantity != null)
              Text(
                'العدد اللازم: $quantity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Dialog widget لإدخال الموقع
class _LocationDialog extends StatelessWidget {
  final void Function(String) onConfirm;

  const _LocationDialog({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final TextEditingController locationController = TextEditingController();

    return AlertDialog(
      title: Text('أدخل موقعك'),
      content: TextField(
        controller: locationController,
        decoration: InputDecoration(hintText: 'أدخل الموقع هنا'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm(locationController.text);
            Navigator.of(context).pop();
          },
          child: Text('تأكيد'),
        ),
      ],
    );
  }
}
