import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/proposed_system_model.dart';
import 'package:alternative_energy_user_app/features/homepage/presentation/screens/widgets/systemDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget ReadyMadeSystemItem(BuildContext context, System proposedSystem) {
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
        color: AppConstants.orangeColor,
        elevation: 12,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/solar-panel (1).png',
                  fit: BoxFit.contain,
                  width: double.infinity * .5,
                  height: 150,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${proposedSystem.name}",
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                "  ${proposedSystem.desc}",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
