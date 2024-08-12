import 'dart:convert';

class SelectedDevice {
  final int id;
  final String name;
  final int num;
  final String from;
  final String to;

  SelectedDevice(
      {required this.id,
      required this.name,
      required this.from,
      required this.num,
      required this.to});

  // factory SelectedDevice.fromJson(Map<String, dynamic> json) {
  //   return SelectedDevice(
  //     id: json['id'],
  //     name: json['name'],
  //     description: json['description'],
  //     image: json['image'],
  //     minCurrent: json['min_current'],
  //     maxCurrent: json['max_current'],
  //     startCurrent: json['start_current'],
  //     createdAt: json['created_at'] != null
  //         ? DateTime.parse(json['created_at'])
  //         : null,
  //     updatedAt: json['updated_at'] != null
  //         ? DateTime.parse(json['updated_at'])
  //         : null,
  //   );
  // }
}
