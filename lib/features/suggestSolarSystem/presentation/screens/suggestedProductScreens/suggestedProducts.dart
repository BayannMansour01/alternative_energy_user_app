import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/repo/suggestSystem_repo_impl.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/manager/cubit/suggest_system_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Suggestedproducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SuggestSystemCubit(getIt.get<SuggestSystemRepoImpl>()),
          // تحميل المنتجات المقترحة
        child: BlocBuilder<SuggestSystemCubit, SuggestSystemState>(
          builder: (context, state) {
            // if (state is SuggestSystemLoading) {
            //   return Center(child: CircularProgressIndicator());
            // } else if (state is SuggestSystemLoaded) {
            //   final products = state.products;
              return 
              
             
       Scaffold(
          // backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Text(
              'المنظومة المقترحة ',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 3, //products.length,
                itemBuilder: (context, index) {
                  // final product = products[index];
                  return Container(
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
                    width: 200,
                    height: 200,
                    margin: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.asset(
                              'assets/images/folders',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ), // رابط الصورة من البيانات
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'الواح شمسية ',
                                style: TextStyle(
                                  color: AppConstants.orangeColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('العدد:2',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text('السعر:250',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // } else if (state is SuggestSystemError) {
          //   return Center(child: Text('حدث خطأ أثناء تحميل البيانات.'));
          // }
          // return Container(); // افتراض عدم وجود حالات أخرى
    bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppConstants.orangeColor, // لون النص
              ),
              onPressed: () {
               
              },
              child: const Text('تأكيد الطلب'),
            ),
          ),
      
          );
    } ));
  }
}
