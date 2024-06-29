import 'dart:io';

import 'package:alternative_energy_user_app/core/utils/service_locator.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/maintenanceRequest_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/repos/home_repo_impl.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class MaintenanceRequestPage extends StatelessWidget {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('طلب صيانة',style: TextStyle(color: Colors.white),),
      ),
      body: BlocProvider(
        create: (context) => homepageCubit(getIt.get<HomeRepoImpl>()),
        child: BlocConsumer<homepageCubit, homepageState>(
          listener: (context, state) {
            // if (state is MaintenanceSuccess) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text('تم إرسال طلب الصيانة بنجاح')),
            //   );
            //   _descriptionController.clear();
            //  Cubit.emit(MaintenanceInitial());
            // } else if (state is MaintenanceFailure) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text('فشل في إرسال طلب الصيانة: ${state.error}')),
            //   );
            // }
          },
          builder: (context, state) {
            final cubit = BlocProvider.of<homepageCubit>(context);
            XFile? _imageFile;
            if (state is MaintenanceImagePicked) {
              _imageFile = state.image;
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'وصف المشكلة',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                  ),
                  SizedBox(height: 20),
                  _imageFile != null
                      ? Image.file(File(_imageFile.path))
                      : Text('لم يتم اختيار صورة'),
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
                        if (_descriptionController.text.isNotEmpty &&
                            _imageFile != null) {
                          final order = MaintenanceRequest(
                              desc: _descriptionController.text,
                              images: [
                                _imageFile.path,
                              ],
                              typeId: 1);
                          cubit.submitMaintenanceRequest(order);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('يرجى إدخال وصف ورفع صورة')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppConstants.orangeColor, // لون النص
                      ),
                      child: Text('إرسال الطلب'),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
