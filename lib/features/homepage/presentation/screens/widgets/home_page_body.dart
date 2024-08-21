import 'package:alternative_energy_user_app/core/constants.dart';
// <<<<<<< Bayan
import 'package:alternative_energy_user_app/core/func/custom_progress_indicator.dart';
import 'package:alternative_energy_user_app/core/func/custom_snack_bar.dart';
import 'package:alternative_energy_user_app/core/utils/app_router.dart';
import 'package:alternative_energy_user_app/core/utils/size_config.dart';
import 'package:alternative_energy_user_app/core/widgets/custom_button.dart';
import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/conversations_screen.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/product_model.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/widgets/custom_drawer.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/order_page.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/widgets/proposedSystem.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/presentation/screen/prev_jobs_page.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/presentation/screens/SuggestsystemScreen.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import 'product_item.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<homepageCubit>(context);
    final ScrollController _scrollController = ScrollController();
    return BlocConsumer<homepageCubit, homepageState>(
      listener: (context, state) {
        cubit.listining = true;
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            100.0, // Adjust the position as needed
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
            // bottomNavigationBar: BottomNavigationBar(
            //   unselectedLabelStyle: TextStyle(
            //     fontSize: 10,
            //     overflow: TextOverflow.ellipsis,
            //   ),
            //   showUnselectedLabels: true,
            //   items: cubit.bottomNavigationBarItems,
            //   onTap: (index) {
            //     cubit.changeBottomNavigationBarIndex(index);
            //   },
            //   currentIndex: cubit.bottomNavigationBarIndex,
            // ),
            bottomNavigationBar: Container(
              margin: EdgeInsets.all(
                  SizeConfig.screenWidth * .045), // تصغير الهامش بنسبة 10%
              height: SizeConfig.screenWidth * .162, // تقليل الارتفاع بنسبة 10%
              decoration: BoxDecoration(
                color: Colors.white, // جعل الخلفية كاملة شفافة
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth *
                        .015), // تصغير الهوامش الداخلية بنسبة 10%
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    cubit.changeBottomNavigationBarIndex(index);
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == cubit.bottomNavigationBarIndex
                            ? SizeConfig.screenWidth *
                                .29 // تقليل العرض عند التحديد بنسبة 10%
                            : SizeConfig.screenWidth *
                                .198, // تقليل العرض عند عدم التحديد بنسبة 10%
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height: index == cubit.bottomNavigationBarIndex
                              ? SizeConfig.screenWidth *
                                  .126 // تقليل الارتفاع عند التحديد بنسبة 10%
                              : 0,
                          width: index == cubit.bottomNavigationBarIndex
                              ? SizeConfig.screenWidth * .315
                              : 0,
                          decoration: BoxDecoration(
                            color: index == cubit.bottomNavigationBarIndex
                                ? Colors.blueAccent.withOpacity(.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == cubit.bottomNavigationBarIndex
                            ? SizeConfig.screenWidth * .306
                            : SizeConfig.screenWidth * .198,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == cubit.bottomNavigationBarIndex
                                      ? SizeConfig.screenWidth * .135
                                      : 0,
                                ),
                                AnimatedOpacity(
                                  opacity:
                                      index == cubit.bottomNavigationBarIndex
                                          ? 1
                                          : 0,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        index == cubit.bottomNavigationBarIndex
                                            ? '${cubit.listOfStrings[index].split(" ")[0]}'
                                            : '',
                                        style: TextStyle(
                                          color: AppConstants.blueColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              12.6, // تصغير حجم النص بنسبة 10%
                                        ),
                                      ),
                                      Text(
                                        index == cubit.bottomNavigationBarIndex
                                            ? '${cubit.listOfStrings[index].split(" ").skip(1).join(" ")}'
                                            : '',
                                        style: TextStyle(
                                          color: AppConstants.blueColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              10.8, // تصغير حجم النص بنسبة 10%
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == cubit.bottomNavigationBarIndex
                                      ? SizeConfig.screenWidth * .045
                                      : 18, // تصغير العرض عند عدم التحديد بنسبة 10%
                                ),
                                cubit.listOfIcons[index],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: state is! GetProposedSystemLoading &&
                    state is! GetProductsLoading &&
                    state is! GetUserInfoLoading
                ? cubit.bottomNavigationBarIndex == 0
                    ? ConversationsScreen()
                    : cubit.bottomNavigationBarIndex == 1
                        ? homeBodyBody(cubit: cubit)
                        : cubit.bottomNavigationBarIndex == 2
                            ? JobListScreen()
                            : SuggestsystemScreen()
                : Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      title: Text(
                        'الصفحة الرئيسية',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ));
      },
    );
  }
}

class homeBodyBody extends StatelessWidget {
  homeBodyBody({
    super.key,
    required this.cubit,
  });

  final homepageCubit cubit;

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<homepageCubit, homepageState>(
      listener: (context, state) {
        if (state is homepageOrdersCleared) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                ' تم إرسال الطلب بنجاح!',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
          context.pop();
        }
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            100.0, // Adjust the position as needed
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
            floatingActionButton: BlocBuilder<homepageCubit, homepageState>(
              builder: (context, orderState) {
                return FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OrderPage(
                          cubit: cubit,
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: AppConstants.blueColor,
                  ),
                );
              },
            ),
            drawer: cubit.userInfo != null
                ? CustomDrawer.getCustomDrawer(
                    userModel: cubit.userInfo!,
                    context,
                    scaffoldKey: cubit.scaffoldKey,
                  )
                : null,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'الصفحة الرئيسية',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: state is! GetProposedSystemLoading
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      // controller: _scrollController,
                      child: SizedBox(
                        height: SizeConfig.screenHeight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 15),
                              child: Text(
                                "منظومات جاهزة مقترحة ",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height: 240,
                              child: ScrollSnapList(
                                listController: _scrollController,
                                curve: Curves.ease,
                                initialIndex: 2.0,
                                allowAnotherDirection: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return ReadyMadeSystemItem(
                                      context, cubit.proposedSystem[index]);
                                },
                                itemCount: cubit.proposedSystem.length,
                                itemSize: 200,
                                onItemFocus: (p0) {},
                                dynamicItemSize: true,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 15),
                              child: Text(
                                "المنتجات الشائعة",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CategoryItem(
                                  onTap: () {
                                    cubit.fetchAllProducts();
                                  },
                                  icon: Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                  text: "الكل",
                                ),
                                // SizedBox(width: 5),
                                CategoryItem(
                                  onTap: () {
                                    cubit.fetchAllPanales();
                                  },
                                  imageicon: ImageIcon(
                                    size: 25,
                                    AssetImage('assets/images/solar-panel.png'),
                                    color: Colors.white,
                                  ),
                                  text: "الألواح",
                                ),
                                // SizedBox(width: 5),
                                CategoryItem(
                                  onTap: () {
                                    cubit.fetchAllBAtteries();
                                  },
                                  imageicon: ImageIcon(
                                    size: 25,
                                    AssetImage('assets/images/accumulator.png'),
                                    color: Colors.white,
                                  ),
                                  text: "البطاريات",
                                ),
                                // SizedBox(width: 5),
                                CategoryItem(
                                  onTap: () {
                                    cubit.fetchAllInverters();
                                  },
                                  imageicon: ImageIcon(
                                      size: 25,
                                      AssetImage(
                                          'assets/images/solar-inverter.png'),
                                      color: Colors.white),
                                  text: "الإنفيرترات",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            state is GetProductsSuccess
                                ? productGridView(
                                    count: cubit.products.length,
                                    product: cubit.products,
                                  )
                                : state is GetPanalesSuccess
                                    ? productGridView(
                                        count: cubit.panales.length,
                                        product: cubit.panales,
                                      )
                                    : state is GetBatteriesSuccess
                                        ? productGridView(
                                            count: cubit.batteries.length,
                                            product: cubit.batteries,
                                          )
                                        : state is GetInvertersSuccess
                                            ? productGridView(
                                                count: cubit.inverters.length,
                                                product: cubit.inverters,
                                              )
                                            : state is GetProductsLoading ||
                                                    state
                                                        is GetBatteriesLoading ||
                                                    state
                                                        is GetInvertersLoading ||
                                                    state is GetPanalesLoading
                                                ? Center(
                                                    heightFactor: 5,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: AppConstants
                                                          .blueColor,
                                                    ),
                                                  )
                                                : productGridView(
                                                    count:
                                                        cubit.products.length,
                                                    product: cubit.products,
                                                  )
                          ],
                        ),
                      ),
                    ),
                  )
                : Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      title: Text(
                        'الصفحة الرئيسية',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    body: Center(
                      child: CircularProgressIndicator(
                        color: AppConstants.backgroundColor,
                      ),
                    ),
                  ));
      },
    );
  }
}

class productGridView extends StatelessWidget {
  const productGridView({
    super.key,
    required this.count,
    required this.product,
  });

  final int count;
  final List<Product> product;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GridView.builder(
        itemCount: count,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (context, index) {
          return ProductItem(
            product: product[index],
          );
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String text;
  final Icon? icon;

  final ImageIcon? imageicon;
  final void Function()? onTap;
  const CategoryItem({
    super.key,
    required this.text,
    this.icon,
    this.imageicon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.amber,
      autofocus: true,
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CircleAvatar(
              child: imageicon ?? icon,
              backgroundColor: AppConstants.blueColor,
              radius: 30,
            ),
          ),
          Text(
            "$text",
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }
}
