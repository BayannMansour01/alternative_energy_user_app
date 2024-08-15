class Suggestedproducts {
  final Panels panels;
  final Batteries batteries;
  final Inverter inverter;
  final int numberOfLithiumBatteries;
  final int numberOfTubularBatteries;
  final int numberOfPanels;
  final int totalCost;

  Suggestedproducts({
    required this.panels,
    required this.batteries,
    required this.inverter,
    required this.numberOfLithiumBatteries,
    required this.numberOfTubularBatteries,
    required this.numberOfPanels,
    required this.totalCost,
  });

  factory Suggestedproducts.fromJson(Map<String, dynamic> json) {
    return Suggestedproducts(
      panels: Panels.fromJson(json['panels']),
      batteries: Batteries.fromJson(json['batteries']),
      inverter: Inverter.fromJson(json['inverter']),
      numberOfLithiumBatteries: json['NumberOfLithiumBatteries'],
      numberOfTubularBatteries: json['NumberOfTubularBatteries'],
      numberOfPanels: json['NumberOfPanels'],
      totalCost: json['total_cost'],
    );
  }
}

class Panels {
  final ProductDetails details;

  Panels({required this.details});

  factory Panels.fromJson(Map<String, dynamic> json) {
    return Panels(
      details: ProductDetails.fromJson(json['details']),
    );
  }
}

class Batteries {
  final ProductDetails lithium;
  final ProductDetails tubular;

  Batteries({required this.lithium, required this.tubular});

  factory Batteries.fromJson(Map<String, dynamic> json) {
    return Batteries(
      lithium: ProductDetails.fromJson(json['lithium']['details']),
      tubular: ProductDetails.fromJson(json['tubular']['details']),
    );
  }
}

class Inverter {
  final ProductDetails details;

  Inverter({required this.details});

  factory Inverter.fromJson(Map<String, dynamic> json) {
    return Inverter(
      details: ProductDetails.fromJson(json['details']),
    );
  }
}

class ProductDetails {
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
  final int? batteryType;
  final int? batteryVolt;
  final int? batteryAmper;
  final int categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductDetails({
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

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
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
