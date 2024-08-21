import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/func/custom_snack_bar.dart';
import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/core/widgets/custom_text_field.dart';
import 'package:alternative_energy_user_app/features/homepage/data/repos/home_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/order_model.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:go_router/go_router.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key, required this.cubit});
  final homepageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homepageCubit(getIt.get<HomeRepoImpl>()),
      child: BlocConsumer<homepageCubit, homepageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'طلباتك',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: cubit.currentOrders.length,
                        itemBuilder: (context, index) {
                          final item = cubit.currentOrders[index];
                          return ListTile(
                            leading: Image.network(
                              "http://${AppConstants.ip}:8000/${item.imageUrl}",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(item.name),
                            subtitle: Text('Amount: ${item.amount}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Total: \$${item.price * item.amount}'),
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      color: AppConstants.orangeColor),
                                  onPressed: () {
                                    cubit.removeProductFromOrder(item.id);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: CustomTextField(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'مطلوب';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      labelText: 'أدخل موقعك الحالي.',
                      width: double.infinity,
                      onChanged: (p0) => cubit.location = p0,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  )
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
                onPressed: () {
                  final orderItems = cubit.currentOrders.map((item) {
                    return ProductOrder(
                      id: item.id,
                      amount: item.amount,
                      name: item.name,
                      imageUrl: item.imageUrl,
                      price: item.price,
                    );
                  }).toList();
                  final order = Order1(
                    typeId: 2,
                    location: cubit.location,
                    products: orderItems,
                  );
                  cubit.submitOrder(order);
                },
                child: const Text('تأكيد الطلب'),
              ),
            ),
          );
        },
      ),
    );
  }
}
