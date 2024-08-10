// To parse this JSON data, do
//
//     final solarSystem = solarSystemFromMap(jsonString);

import 'dart:convert';

SolarSystem solarSystemFromMap(String str) =>
    SolarSystem.fromMap(json.decode(str));

String solarSystemToMap(SolarSystem data) => json.encode(data.toMap());

class SolarSystem {
  Panels panels;
  Batteries batteries;
  Inverter inverter;
  int totalCost;

  SolarSystem({
    required this.panels,
    required this.batteries,
    required this.inverter,
    required this.totalCost,
  });

  factory SolarSystem.fromMap(Map<String, dynamic> json) => SolarSystem(
        panels: Panels.fromMap(json["panels"]),
        batteries: Batteries.fromMap(json["batteries"]),
        inverter: Inverter.fromMap(json["inverter"]),
        totalCost: json["total_cost"],
      );

  Map<String, dynamic> toMap() => {
        "panels": panels.toMap(),
        "batteries": batteries.toMap(),
        "inverter": inverter.toMap(),
        "total_cost": totalCost,
      };
}

class Batteries {
  int quantity;
  String type;
  int capacityPerBattery;

  Batteries({
    required this.quantity,
    required this.type,
    required this.capacityPerBattery,
  });

  factory Batteries.fromMap(Map<String, dynamic> json) => Batteries(
        quantity: json["quantity"],
        type: json["type"],
        capacityPerBattery: json["capacity_per_battery"],
      );

  Map<String, dynamic> toMap() => {
        "quantity": quantity,
        "type": type,
        "capacity_per_battery": capacityPerBattery,
      };
}

class Inverter {
  String type;
  int powerRating;

  Inverter({
    required this.type,
    required this.powerRating,
  });

  factory Inverter.fromMap(Map<String, dynamic> json) => Inverter(
        type: json["type"],
        powerRating: json["power_rating"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "power_rating": powerRating,
      };
}

class Panels {
  int quantity;
  int powerPerPanel;

  Panels({
    required this.quantity,
    required this.powerPerPanel,
  });

  factory Panels.fromMap(Map<String, dynamic> json) => Panels(
        quantity: json["quantity"],
        powerPerPanel: json["power_per_panel"],
      );

  Map<String, dynamic> toMap() => {
        "quantity": quantity,
        "power_per_panel": powerPerPanel,
      };
}
