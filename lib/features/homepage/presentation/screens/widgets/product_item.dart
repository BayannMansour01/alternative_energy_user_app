import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/size_config.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/widgets/ProductDetailsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/order_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/product_model.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_state.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<homepageCubit>(context);
    return BlocConsumer<homepageCubit, homepageState>(
      listener: (context, state) {
        // Add any additional listeners if needed
      },
      builder: (context, state) {
        // int amount = cubit.getQuantity(product.id);

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(
                  product: product,
                  cubit: cubit,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            // width: 200,
            // height: SizeConfig.defaultSize * 100,
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.network(
                        "http://${AppConstants.ip}:8000/${product.image}", // Ensure the image URL is accessible
                        height: SizeConfig.defaultSize * 12,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/LOGO.png',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          product.name,
                          style: TextStyle(
                            color: AppConstants.orangeColor,
                            fontSize: SizeConfig.defaultSize * 1.1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${product.price} ل.س',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: SizeConfig.defaultSize * 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Container(
                        height: SizeConfig.defaultSize * 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                cubit.decreaseQuantity(product.id);
                              },
                              icon: Icon(Icons.remove),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${cubit.getQuantity(product.id)}'),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.increaseQuantity(product.id);
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            cubit.addProductToOrder(ProductOrder(
                              price: product.price,
                              id: product.id,
                              amount: cubit.getQuantity(product.id),
                              name: product.name,
                              imageUrl: product.image,
                            ));
                          },
                          child: Container(
                            width: double.infinity,
                            height: SizeConfig.defaultSize * 20,
                            decoration: BoxDecoration(
                              color: AppConstants.orangeColor,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(12)),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Center(
                                child: Text(
                                  'إضافة إلى السلة',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
