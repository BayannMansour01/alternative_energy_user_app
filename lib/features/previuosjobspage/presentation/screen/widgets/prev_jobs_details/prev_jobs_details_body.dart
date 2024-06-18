import 'package:alternative_energy_user_app/core/func/custom_progress_indicator.dart';
import 'package:alternative_energy_user_app/core/func/custom_snack_bar.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/models/job_model.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/data/repos/prev_job_details_repo_impl.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/presentation/manager/prev_job_details_cubit.dart';
import 'package:alternative_energy_user_app/features/previuosjobspage/presentation/manager/prev_job_details_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
class JobDetailsScreen extends StatelessWidget {
  final int jobId;
  final String token;

  const JobDetailsScreen({super.key, required this.jobId, required this.token});

  @override
  Widget build(BuildContext context) {
     
    return BlocProvider(
      create: (context) => JobDetailsCubit(JobDetailsRepoImpl())..fetchJobDetails(jobId, token),
      child: BlocConsumer <JobDetailsCubit ,JobDetailsState>(
      listener: (context, state) async {
        if (state is JobDetailsLoading && !CustomProgressIndicator.isOpen) {
          CustomProgressIndicator.showProgressIndicator(context);
        } else {
          if (CustomProgressIndicator.isOpen) {
            context.pop();
          }
          if (state is JobDetailsFailure) {
            CustomSnackBar.showErrorSnackBar(context,
                message: state.errorMessage);
          }
        }
       
      },
       builder: (context, state) {
       
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "تفاصيل العمل",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: BlocBuilder<JobDetailsCubit, JobDetailsState>(
              builder: (context, state) {
                if (state is JobDetailsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is JobDetailsFailure) {
                  return Center(child: Text(state.errorMessage));
                } else if (state is JobDetailsSuccess) {
           
                  final job = state.job;
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          job.disc,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'تاريخ الإنشاء: ${job.createdAt}',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          'تاريخ التحديث: ${job.updatedAt}',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'الصور:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        job.images.isNotEmpty
                            ? CarouselSlider(
                                options: CarouselOptions(
                                  height: 200.0,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: false,
                                  
                                ),
                                items: job.images.map((image) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                        ),
                                        child: Image.network(
                                          'http://192.168.1.103:8000/' + 
                      image.image, // تأكد من استخدام URL مطلق
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              )
                            : Text('No images available'),
                      ],
                    ),
                  );
                } else {
                  return Center(child: Text('Unknown state'));
                }
              },
            ),
          ),
        );}
      ),
    );
  }
}
