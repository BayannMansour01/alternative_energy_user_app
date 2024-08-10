import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/core/utils/size_config.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/order_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/repos/home_repo_impl.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:flutter/material.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  final homepageCubit cubit;
  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homepageCubit(getIt.get<HomeRepoImpl>()),
      child: BlocConsumer<homepageCubit, homepageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          int amount = cubit.getQuantity(product.id);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                product.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      "http://${AppConstants.ip}:8000/${product.image}",
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 16),
                    Text(
                      product.name,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.orangeColor),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'السعر : ${product.price} ل.س',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    product.categoryId == 1
                        ? Text(
                            'سعة اللوح الشمسي ${product.panelCapacity}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[700],
                            ),
                          )
                        : product.categoryId == 2
                            ? Column(children: [
                                Text(
                                  'نوع البطارية ${product.batteryType}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Text(
                                  'أمبير البطارية ${product.batteryAmper}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Text(
                                  'فولت البطارية ${product.batteryVolt}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ])
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'استطاعة الانفيرتر ${product.inverterWatt}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Text(
                                    'فولت الانفيرتر ${product.inverterVolt}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                    SizedBox(height: 16),
                    Text(
                      '${product.disc}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: SizeConfig.defaultSize * 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' حدد الكمية المطلوبة ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.decreaseQuantity(product.id);
                            },
                            icon: Icon(
                              Icons.remove,
                              color: AppConstants.orangeColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('$amount'),
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.increaseQuantity(product.id);
                            },
                            icon: Icon(
                              Icons.add,
                              color: AppConstants.orangeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: AppConstants.orangeColor, // لون النص
                        ),
                        onPressed: () {
                          cubit.addProductToOrder(ProductOrder(
                            price: product.price,
                            id: product.id,
                            amount: 1,
                            name: product.name,
                            imageUrl: product.image,
                          ));
                        },
                        child: Text('إضافة إلى السلة'),
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
