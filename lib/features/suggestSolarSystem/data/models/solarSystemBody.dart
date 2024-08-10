// To parse this JSON data, do
//
//     final solarSystembody = solarSystembodyFromMap(jsonString);

import 'dart:convert';

SolarSystembody solarSystembodyFromMap(String str) =>
    SolarSystembody.fromMap(json.decode(str));

String solarSystembodyToMap(SolarSystembody data) => json.encode(data.toMap());

class SolarSystembody {
  int systemVoltage;
  int inverterWatt;
  int inverterStartWatt;
  int totalPowerNight;
  int peakPowerNight;
  int pvCapacity;
  int aha;

  SolarSystembody({
    required this.systemVoltage,
    required this.inverterWatt,
    required this.inverterStartWatt,
    required this.totalPowerNight,
    required this.peakPowerNight,
    required this.pvCapacity,
    required this.aha,
  });

  factory SolarSystembody.fromMap(Map<String, dynamic> json) => SolarSystembody(
        systemVoltage: json["SystemVoltage"],
        inverterWatt: json["InverterWatt"],
        inverterStartWatt: json["InverterStartWatt"],
        totalPowerNight: json["TotalPowerNight"],
        peakPowerNight: json["PeakPowerNight"],
        pvCapacity: json["pvCapacity"],
        aha: json["Aha"],
      );

  Map<String, dynamic> toMap() => {
        "SystemVoltage": systemVoltage,
        "InverterWatt": inverterWatt,
        "InverterStartWatt": inverterStartWatt,
        "TotalPowerNight": totalPowerNight,
        "PeakPowerNight": peakPowerNight,
        "pvCapacity": pvCapacity,
        "Aha": aha,
      };
}
