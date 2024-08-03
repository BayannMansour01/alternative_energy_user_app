class Product {
  final int id;
  final String name;
  final String image;
  final int price;
  final int available;
  final String disc;
  final int quantity;
  final int? inverterWatt;
  final int? inverterStartWatt;
  final int? inverterVolt;
  final int? panelCapacity;
  final String? batteryType;
  final int? batteryVolt;
  final int? batteryAmper;
  final int categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.available,
    required this.disc,
    required this.quantity,
    this.inverterWatt,
    this.inverterStartWatt,
    this.inverterVolt,
    this.panelCapacity,
    this.batteryType,
    this.batteryVolt,
    this.batteryAmper,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      available: json['available'],
      disc: json['disc'],
      quantity: json['quantity'],
      inverterWatt: json['InverterWatt'],
      inverterStartWatt: json['InverterStartWatt'],
      inverterVolt: json['inverter_volt'],
      panelCapacity: json['panel_capacity'],
      batteryType: json['battery_type'],
      batteryVolt: json['battery_volt'],
      batteryAmper: json['battery_amper'],
      categoryId: json['category_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
