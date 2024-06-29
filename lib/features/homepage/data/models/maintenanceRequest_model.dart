import 'dart:io';

class MaintenanceRequestModel {
  int typeId;
  File image;
  String desc;

  MaintenanceRequestModel({required this.typeId, required this.image, required this.desc});

  Map<String, dynamic> toJson() {
    return {
      'type_id': typeId,
      'image': image.path,
      'desc': desc,
    };
  }
}