import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/features/homepage/data/repos/home_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/order_model.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_state.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key, required this.cubit});
  final homepageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homepageCubit(getIt.get<HomeRepoImpl>()),
      child: BlocConsumer<homepageCubit, homepageState>(
        listener: (context, state) {

           if (state is homepageOrdersCleared) {
            ScaffoldMessenger.
            of(context).
            showSnackBar(
              SnackBar(
                content: Text('تم إرسال الطلب وتصفير الطلبات الحالية.',
                style: TextStyle(color: AppConstants.orangeColor),),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'طلباتك',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: ListView.builder(
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
                        icon: Icon(Icons.delete, color:AppConstants.orangeColor),
                        onPressed: () {
                          cubit.removeProductFromOrder(item.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor:AppConstants.orangeColor, // لون النص
                 
                ),
                
                onPressed: () {
                  print(cubit.currentOrders.length);
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
                    location: 'location', 
                    products: orderItems,
                  );
                  cubit.submitOrder(order);
                },
                child: Text('إرسال الطلب'),
              ),
            ),
          );
        },
      ),
    );
  }
}
