

// import 'dart:developer';
// import 'package:alternative_energy_user_app/core/func/custom_progress_indicator.dart';
// import 'package:alternative_energy_user_app/core/func/custom_snack_bar.dart';
// import 'package:alternative_energy_user_app/core/utils/app_router.dart';

// import 'package:alternative_energy_user_app/core/utils/size_config.dart';
// import 'package:alternative_energy_user_app/core/widgets/custom_button.dart';
// import 'package:alternative_energy_user_app/core/widgets/custom_text_field.dart';
// import 'package:alternative_energy_user_app/core/widgets/space_widgets.dart';
// import 'package:alternative_energy_user_app/features/login_screen/cubit/login_cubit.dart';
// import 'package:alternative_energy_user_app/features/login_screen/cubit/login_states.dart';
// import 'package:alternative_energy_user_app/features/login_screen/widgets/AppBarBorder.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';


// class LoginViewBody extends StatelessWidget {
//   const LoginViewBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//  return BlocConsumer<LoginCubit, LoginStates>(
//       listener: (context, state) {
//         if (state is LoginLoading && !CustomProgressIndicator.isOpen) {
//           CustomProgressIndicator.showProgressIndicator(context);
//         } else {
//           if (CustomProgressIndicator.isOpen) context.pop();
//           if (state is LoginFailure) {
//             CustomSnackBar.showErrorSnackBar(
//               context,
//               message: state.failureMsg,
//             );
//           } else if (state is LoginSuccess) {
//             context.pushReplacement(
//               AppRouter.kGroupsView,
//               extra: state.userModel.token,
//             );
//           }
//         }
//       },



//  buildWhen: (prev, cur) => cur is LoginInitial,
//       builder: (context, state) {
//         final LoginCubit cubit = BlocProvider.of<LoginCubit>(context);
     

//     return SingleChildScrollView(
//       child: Center(
//         child: Column(
//           children: [
//            Container(
//           height: 280,
//           width:1300 ,
//           decoration: ShapeDecoration(
//             color: Colors.orange,
//             shape: AppBarBorder(),
            
//             shadows: [
//               BoxShadow(
//         color: Colors.black.withOpacity(0.7),
//         blurRadius: 18.0,
//         spreadRadius: 2.0,
//               ),
//             ],
//           ),
//           child:  Center(child: Text("تسجيل الدخول ",style: TextStyle(color: Colors.grey,fontSize: 50),)),
//         ),
//             Container(
//                decoration: BoxDecoration(
                    
//                     borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
//                   ),
//                   child: Form(
//                    // key: cubit.formKey,
//                     child: Column(
//                       children: [
//                      //    const VerticalSpace(10),
                    
//                    //   const VerticalSpace(2),
//                           CustomTextField(
//                         prefixIcon: const Icon(Icons.email),
//                           textInputAction: TextInputAction.next,
//                           labelText: 'البريد الإلكتروني',
//                          // onChanged: (p0) => cubit.email = p0,
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                          const VerticalSpace(1),
//                        const PasswordTextField(),
//                          const VerticalSpace(1),
//                           CustomButton(
//                           text: 'تسجيل الدخول ',
//                           color: Colors.blue,
//                           onTap: ()async {}
//                             // log(CacheHelper.getData(key: 'Token').toString());
//                             // if (cubit.formKey.currentState!.validate()) {
//                             //   await cubit.login();
//                         //    }
//                       //    },
//                         ),
                      
//                          const VerticalSpace(3),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                              "ليس لديك حساب؟",
//                               style: TextStyle(
//                                 fontSize: SizeConfig.defaultSize,
//                                 color: Colors.grey
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 context.push(AppRouter.kRegisterView);
//                               },
//                               child: const Text(
//                                 'سجل الآن ',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18,
//                                   color: Colors.orange
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     )
                    
                    
//                      ),
//             ),
//           ],
//         ),
//       ),
//     )
    
    
    
    
    
//      ;});
// }
// }

