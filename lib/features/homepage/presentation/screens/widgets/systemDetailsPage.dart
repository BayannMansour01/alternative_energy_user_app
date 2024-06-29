import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/core/widgets/custom_text_field.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/order_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/repos/home_repo_impl.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:flutter/material.dart';
import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/proposed_system_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SystemDetailsPage extends StatelessWidget {
  final System system;
  final TextEditingController _location = TextEditingController();

  SystemDetailsPage({required this.system});

  @override
  Widget build(BuildContext context) {
    double totalCost = system.products.fold(0, (sum, product) => sum + product.price);

    return BlocProvider(
      create: (context) => homepageCubit(getIt.get<HomeRepoImpl>()),
      child: BlocConsumer<homepageCubit, homepageState>(
        listener: (context, state) {
          if (state is SubmitOrderSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Order submitted successfully!')),
            );
          } else if (state is SubmitOrderFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to submit order: ${state.errMessage}')),
            );
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<homepageCubit>(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                system.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'وصف المنظومة',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(system.desc),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'المنتجات',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: system.products.map((product) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              width: 200,
                              height: 200,
                              margin: EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                child: Column(
                                  children: [
                                    Image.network(
                                      "http://${AppConstants.ip}:8000/${product.image}",
                                      height: 130,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      product.name,
                                      style: TextStyle(
                                        color: AppConstants.orangeColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '\$ ${product.price}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'السعر ',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('\$ $totalCost'),
                    SizedBox(height: 20),
                    // Text(
                    //   'موقعك الحالي',
                    //   style: TextStyle(
                    //     color: Colors.black54,
                    //     fontSize: 18,
                    //   ),
                    // ),
                    // SizedBox(height: 10),
                    // TextFormField(
                    //   cursorColor: AppConstants.blueColor,
                    //   controller: _location,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     fillColor: AppConstants.blueColor,
                    //   ),
                    // ),
                    CustomTextField(
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'مطلوب';
                              }
                              return null;
                            },
                       
                            textInputAction: TextInputAction.next,
                            labelText:'موقعك الحالي',
                            width: double.infinity,
                           onChanged: (p0) => cubit.location = p0,
                            keyboardType: TextInputType.emailAddress,
                          ),
                   // Spacer(),
                    SizedBox(height:70),
                    ElevatedButton(
                      onPressed: () {
                        final order = Order1(
                          typeId: 2,
                          location: cubit.location ,
                          products: system.products.map((product) {
                            return ProductOrder(
                              id: product.id,
                              amount: 10, // Assuming the amount is 1 for each product
                              name: product.name,
                              price: product.price,
                              imageUrl: product.image,
                            );
                          }).toList(),
                        );
                        
                        cubit.submitOrder(order);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppConstants.orangeColor,
                      ),
                  
                      child: Center(
                        child: Text('إضافة المنظومة إلى الطلب'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
