import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/proposed_system_model.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/widgets/systemDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget ReadyMadeSystemItem(BuildContext context, System proposedSystem) {
  //Product product = productList[index];
  return SizedBox(
    width: 200,
    height: 200,
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SystemDetailsPage(
              system: proposedSystem,
            ),
          ),
        );
      },
      child: Card(
        color: AppConstants.orangeColor.withOpacity(0.9),
        elevation: 12,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Column(
            children: [
              // Image.asset(
              //   'assets/images/system.png',
              //   fit: BoxFit.cover,
              //   width: double.infinity,
              //   height: 180,
              // ),
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                child: Image.asset(
                  'assets/images/LOGO.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 180,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${proposedSystem.name}",
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
              // Text(
              //   "${proposedSystem.desc}",
              //   style: const TextStyle(fontSize: 10),
              // ),
            ],
          ),
        ),
      ),
    ),
  );
}
