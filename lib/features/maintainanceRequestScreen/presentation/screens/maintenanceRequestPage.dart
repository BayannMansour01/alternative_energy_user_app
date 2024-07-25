import 'dart:io';

import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/core/widgets/custom_text_field.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/maintenanceRequest_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/repos/home_repo_impl.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:alternative_energy_user_app/features/maintainanceRequestScreen/data/repos/maintanance_repo_impl.dart';
import 'package:alternative_energy_user_app/features/maintainanceRequestScreen/presentation/manager/cubit/maintanance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class MaintenanceRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'طلب صيانة',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocProvider(
        create: (context) => MaintananceCubit(getIt.get<MaintananceRepoImpl>()),
        child: BlocConsumer<MaintananceCubit, MaintananceState>(
          listener: (context, state) {
            if (state is MaintenanceSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم إرسال طلب الصيانة بنجاح')),
              );

              BlocProvider.of<MaintananceCubit>(context)
                  .emit(MaintenanceInitial());
            } else if (state is MaintenanceFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text('فشل في إرسال طلب الصيانة: ${state.errMessage}')),
              );
            }
          },
          builder: (context, state) {
            final cubit = BlocProvider.of<MaintananceCubit>(context);

            XFile? _imageFile;
            if (state is MaintenanceImagePicked) {
              _imageFile = state.image;
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'مطلوب';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      labelText: 'وصف المشكلة',
                      width: double.infinity,
                      maxLines: 5,
                      onChanged: (p0) => cubit.maintenance_order = p0,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: _imageFile != null
                          ? Image.file(
                              File(_imageFile.path),
                              width: double.infinity,
                              height: double.infinity,
                            )
                          : Text('لم يتم اختيار صورة'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        cubit.pickImage();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppConstants.orangeColor, // لون النص
                      ),
                      child: Text('اختر صورة'),
                    ),
                    SizedBox(height: 20),
                    if (state is MaintenanceLoading)
                      CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: () {
                          // if (cubit.maintenance_order.isNotEmpty &&
                          //     _imageFile != null) {
                          //   final order = ma(
                          //       desc:cubit.maintenance_order,
                          //       image:
                          //         _imageFile.path,

                          //       typeId: 1);
                          cubit.submitMaintenanceRequest();
                          // } else {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text('يرجى إدخال وصف ورفع صورة')),
                          // );
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: AppConstants.orangeColor, // لون النص
                        ),
                        child: Text('إرسال الطلب'),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
