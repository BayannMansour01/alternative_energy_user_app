import 'dart:convert';

class Device {
  final int id;
  final String name;
  final String description;
  final String image;
  final int minCurrent;
  final int maxCurrent;
  final int startCurrent;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Device({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.minCurrent,
    required this.maxCurrent,
    required this.startCurrent,
    this.createdAt,
    this.updatedAt,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      minCurrent: json['min_current'],
      maxCurrent: json['max_current'],
      startCurrent: json['start_current'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}
