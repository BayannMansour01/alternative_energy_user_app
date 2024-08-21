import 'dart:developer';

import 'dart:math';

import 'package:alternative_energy_user_app/features/homepage/data/models/order_model.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/suggestedProducts.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/device_model.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/selected_device_model.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/solarSystemBody.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/models/solarSystemMoldel.dart';
import 'package:alternative_energy_user_app/features/suggestSolarSystem/data/repo/suggestSystem_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'suggest_system_state.dart';

class SuggestSystemCubit extends Cubit<SuggestSystemState> {
  SuggestSystemCubit(this.Repo) : super(SuggestSystemInitial());

  final SuggestSysyemRepo Repo;
  void updatecard(double page) {
    emit(SuggestSystemUpdatedpage(page));
  }

  String location = '';
  List<ProductOrder> currentOrders = [];
  Map<int, int> DeviceQuantities = {};

  void increaseQuantity(int productId) {
    if (DeviceQuantities.containsKey(productId)) {
      DeviceQuantities[productId] = DeviceQuantities[productId]! + 1;
    } else {
      DeviceQuantities[productId] = 1;
    }
    emit(DeviceAmountChanged());
  }

  void decreaseQuantity(int productId) {
    if (DeviceQuantities.containsKey(productId) &&
        DeviceQuantities[productId]! > 1) {
      DeviceQuantities[productId] = DeviceQuantities[productId]! - 1;
    } else {
      DeviceQuantities[productId] = 1;
    }
    emit(DeviceAmountChanged());
  }

  int getQuantity(int productId) {
    return DeviceQuantities[productId] ?? 1;
  }

  RangeValues hoursRange = RangeValues(0, 10);
  RangeValues powerRange = RangeValues(0, 20000);
  // يجب أن تحتوي على الأجهزة المحملة من السيرفر
  Map<int, double> currentValues = {}; // تخزين القيم الحالية لكل جهاز

  void updateHoursRange(RangeValues newRange) {
    // Ensure newRange values are within bounds
    // if (newRange.start >= 0 && newRange.end <= 24) {
    // void log;
    print('newRange${newRange}');
    hoursRange = newRange;
    emit(SuggestSystemUpdatedHoursRange(newRange));
    // }
  }

  double currentValue = 0;

  void updatePowerRange(RangeValues newRange) {
    powerRange = newRange;
    emit(SuggestSystemUpdatedPowerRange(newRange));
  }

  void updateCurrentValue(int deviceId, double value) {
    currentValues[deviceId] = value;
    changeDeviceWatt(value.toInt(), deviceId);
    emit(SuggestSystemUpdatedPowerRange(
        RangeValues(currentValues[deviceId]!, powerRange.end)));
  }

  void updatePowerRangeValues(int minPower, int maxPower) {
    powerRange = RangeValues(minPower.toDouble(), maxPower.toDouble());
    emit(SuggestSystemUpdatedPowerRange(powerRange));
  }

  void updatePage(double page) => emit(SuggestSystemUpdatedpage(page));

  // Map<String, Map<String, int?>> devices = {
  //   "fridge": {"startingWatt": 600, "watt": 300},
  //   "light": {"startingWatt": null, "watt": 25},
  //   "tv": {"startingWatt": null, "watt": 100},
  //   "fan": {"startingWatt": null, "watt": 60},
  //   "charger": {"startingWatt": null, "watt": 100},
  //   "hover": {"startingWatt": 1600, "watt": 1000},
  // };

  // Map<String, Map<String, dynamic>> userDevices = {
  //   "fridge": {"num": 2, "from": '12:00PM', "to": "12:00PM"},
  //   "light": {"num": 6, "from": '12:00PM', "to": "12:00PM"},
  //   "fan": {"num": 1, "from": '12:00PM', "to": "12:00PM"},
  //   "tv": {"num": 1, "from": '12:00PM', "to": "12:00PM"},
  //   "charger": {"num": 3, "from": '12:00PM', "to": "12:00PM"},
  //   "hover": {"num": 1, "from": '12:00PM', "to": "12:00PM"},
  // };

  // Map<String, Map<String, dynamic>> userDevices = {
  //   "fridge": {"num": 2, "from": '12:00PM', "to": "12:00PM"},
  //   "light": {"num": 6, "from": '08:00PM', "to": "12:00AM"},
  //   "fan": {"num": 1, "from": '12:00AM', "to": "09:00AM"},
  //   "tv": {"num": 1, "from": '09:30PM', "to": "11:00PM"},
  //   "charger": {"num": 3, "from": '12:00PM', "to": "04:00PM"},
  //   "hover": {"num": 1, "from": '07:00AM', "to": "02:00PM"},
  // };

  List<Device> devicesFromServer = [];

  List<SelectedDevice> selectedDevicesList = [];

  Map<String, Map<String, int?>> devicesMap = {};

  Map<String, Map<String, dynamic>> selectedDeviceMap = {};

  void devicesFromListToMap(List<Device> devicesFromServer) {
    for (var device in devicesFromServer) {
      int between = (device.minCurrent + device.maxCurrent) ~/ 2;
      devicesMap[device.name] = {
        "id": device.id,
        "startingWatt": device.startCurrent,
        "watt": between
      };
    }
    devicesMap.forEach((key, value) {
      // print('$key: $value');
    });
    emit(DevicesFromListToMap());
    // Print the resulting map
  }

  void selectedDevicesFromListToMap(List<SelectedDevice> selectedDevice) {
    for (var device in selectedDevice) {
      selectedDeviceMap[device.name] = {
        "id": device.id,
        "num": device.num,
        "from": device.from,
        "to": device.to,
      };
    }
    selectedDeviceMap.forEach((key, value) {
      // print('$key: $value');
    });
    emit(SelectedevicesFromListToMap());
  }

  void fetchAllDevices() async {
    var result = await Repo.fetchDevices();
    result.fold((failure) {
      emit(getDvicesFilureState(failure.errorMessege));
    }, (data) {
      devicesFromServer = data;
      devicesFromListToMap(devicesFromServer);
      emit(getDvicessSuccessState(devicesFromServer));
    });
  }

  void changeDeviceWatt(int watt, int deviceId) {
    for (var key in devicesMap.keys) {
      if (devicesMap[key]?["id"] == deviceId) {
        devicesMap[key]?["watt"] = watt;
        break;
      }
    }
    devicesMap.forEach((key, value) {
      // print('$key: $value');
    });
    emit(DeviceWattChanged());
  }

  List<int> selectedDevices = [];
  void toggleDeviceSelection(int deviceId) {
    if (selectedDevices.contains(deviceId)) {
      selectedDevices.remove(deviceId);
    } else {
      selectedDevices.add(deviceId);
    }
    emit(SuggestSystemUpdated());
  }

  void clearSelections() {
    selectedDevices.clear();
    emit(SuggestSystemUpdated());
  }

  void selectDevices(SelectedDevice devices) {
    selectedDevicesList.add(devices);
    emit(addSelelctDevice());
  }

  int timeToMinutes(String time) {
    int hour = int.parse(time.split(':')[0]);
    int minute = int.parse(time.split(':')[1].substring(0, 2));
    String period = time.split(':')[1].substring(2).toUpperCase();
    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }
    return hour * 60 + minute;
  }

  String minutesToTime(int minutes) {
    int hour = minutes ~/ 60;
    int minute = minutes % 60;
    String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}$period';
  }

  int calculateNightUsage(String device, Map<String, Map<String, int?>> devices,
      Map<String, dynamic> details) {
    int power = devices[device]!['watt']!;
    int num = details['num'];
    int start = timeToMinutes(details['from']);
    int end = timeToMinutes(details['to']);
    int nightStart = timeToMinutes('04:00PM');
    int nightEnd = timeToMinutes('09:00AM');
    int totalMinutes = 0;
    if (start == end) {
      totalMinutes = (24 * 60) - (nightStart - nightEnd);
    } else if (start <= nightEnd || end >= nightStart) {
      if (start <= nightEnd && end >= nightStart) {
        totalMinutes = (nightEnd - start) + (end - nightStart);
      } else if (start <= nightEnd) {
        totalMinutes = nightEnd - start;
      } else if (end >= nightStart) {
        totalMinutes = end - nightStart;
      }
    }
    return (power * num * totalMinutes / 60).round();
  }

  Map<String, dynamic> calculatePowers(Map<String, Map<String, int?>> devices,
      Map<String, Map<String, dynamic>> userDevices) {
    // إنشاء مصفوفة لتتبع الاستطاعة المطلوبة في كل دقيقة
    print('devices ${devices}');
    print('userdevices ${userDevices}');
    List<int> powerUsage = List.filled(24 * 60, 0);
    List<Set<String>> deviceUsage = List.generate(24 * 60, (_) => <String>{});

    // حساب الاستطاعة المطلوبة لكل جهاز في كل دقيقة
    userDevices.forEach((device, details) {
      int power = (devices[device]!['watt']! * details["num"]).toInt();
      int start = timeToMinutes(details["from"]);
      int end = timeToMinutes(details["to"]);
      // إذا كان الوقت من الساعة 12:00PM إلى 12:00PM يعني الجهاز يعمل 24 ساعة
      if (start == end) {
        for (int i = 0; i < 24 * 60; i++) {
          powerUsage[i] += power;
          deviceUsage[i].add(device);
        }
      } else {
        for (int i = start; i != end; i = (i + 1) % (24 * 60)) {
          powerUsage[i] += power;
          deviceUsage[i].add(device);
        }
      }
    });

    // تحديد الفترات الزمنية
    int startSun = timeToMinutes('09:00AM');
    int endSun = timeToMinutes('04:00PM');
    int startNight = timeToMinutes('04:00PM');
    int endNight = timeToMinutes('09:00AM');

    // العثور على الاستطاعة العظمى والفترات الزمنية
    int peakPowerSun = 0;
    int peakPowerNight = 0;
    int peakStartSun = startSun;
    int peakEndSun = startSun;
    int peakStartNight = startNight;
    int peakEndNight = startNight;

    Set<String> devicesInPeakSun = {};
    Set<String> devicesInPeakNight = {};
    Set<String> totalDevicesNight = {};

    for (int i = 0; i < 24 * 60; i++) {
      if (i >= startSun && i < endSun) {
        if (powerUsage[i] > peakPowerSun) {
          peakPowerSun = powerUsage[i];
          peakStartSun = i;
          peakEndSun = i;
          devicesInPeakSun = deviceUsage[i];
        } else if (powerUsage[i] == peakPowerSun) {
          peakEndSun = i;
        }
      }
      if (i >= startNight || i < endNight) {
        if (powerUsage[i] > peakPowerNight) {
          peakPowerNight = powerUsage[i];
          peakStartNight = i;
          peakEndNight = i;
          devicesInPeakNight = deviceUsage[i];
        } else if (powerUsage[i] == peakPowerNight) {
          peakEndNight = i;
        }
        totalDevicesNight.addAll(deviceUsage[i]);
      }
    }

    int totalNightUsage = 0;
    userDevices.forEach((device, details) {
      totalNightUsage += calculateNightUsage(device, devices, details);
    });

    return {
      'peakPowerSun': (peakPowerSun * 1.15).round(),
      'devicesInPeakSun': devicesInPeakSun.toList(),
      'peakStartSun': peakStartSun,
      'peakEndSun': peakEndSun,
      'peakPowerNight': (peakPowerNight * 1.15).round(),
      'devicesInPeakNight': devicesInPeakNight.toList(),
      'peakStartNight': peakStartNight,
      'peakEndNight': peakEndNight,
      'totalPowerNight': (totalNightUsage * 1.15).round(),
      'totalDevicesNight': totalDevicesNight.toList(),
    };
  }

  int calculateSystemVoltage(int totalWatt) {
    if (totalWatt <= 1000) {
      return 12;
    }

    if (totalWatt <= 2000) {
      return 24;
    }

    return 48;
  }

  int calculateAha(int totalNightWatt, int systemVoltage) {
    int tc = 1;
    int da = 1;
    int dm = 1;
    int dod = (100 / 100).round();
    int ahd = (totalNightWatt / systemVoltage).round();
    int aha = (ahd * tc * da * dm * dod).round();
    return aha;
  }

  int calculatePv(int peakPowerSun, int totalNightWatt) {
    int sunHours = 7; // from 09:00AM  to 04:00PM
    int pv = ((peakPowerSun + totalNightWatt) / sunHours).round();
    return pv;
  }

  Map<String, dynamic> suggestSystem(
      Map<String, Map<String, dynamic>> userDevices) {
    Map<String, dynamic> powers = calculatePowers(devicesMap, userDevices);

    print(powers.toString());

    int peakPowerSun = powers['peakPowerSun'];
    int peakPowerNight = powers['peakPowerNight'];
    int totalPowerNight = powers['totalPowerNight'];
    List<String> devicesInPeakSun = powers['devicesInPeakSun'];
    List<String> devicesInPeakNight = powers['devicesInPeakNight'];

    // int systemVoltage =
    //     calculateSystemVoltage(max(peakPowerNight, peakPowerSun));

    // int peakPowerSunStartWatt = 0;
    // int peakPowerNightStartWatt = 0;

    int systemVoltage =
        calculateSystemVoltage(max(peakPowerNight, peakPowerSun));
    int peakPowerSunStartWatt = 0;
    int peakPowerNightStartWatt = 0;

    for (String device in devicesInPeakSun) {
      if (devicesMap[device]!['startingWatt'] != null) {
        peakPowerSunStartWatt += devicesMap[device]!['startingWatt']!;
      }
    }

    for (String device in devicesInPeakNight) {
      if (devicesMap[device]!['startingWatt'] != null) {
        peakPowerSunStartWatt += devicesMap[device]!['startingWatt']!;
      }
    }

    return {
      "SystemVoltage": systemVoltage,
      "Aha": calculateAha(totalPowerNight, systemVoltage),
      "TotalPowerNight": totalPowerNight,
      "PeakPowerNight": peakPowerNight,
      //  "PeakPowerSun": peakPowerSun,

      // "PeakPowerSun": peakPowerSun,

      "PV": calculatePv(peakPowerSun, totalPowerNight),
      "InverterWatt": (max(peakPowerNight, peakPowerSun) * 1.15).round(),
      "InverterStartWatt":
          (max(peakPowerNightStartWatt, peakPowerSunStartWatt) * 1.15).round(),
    };
  }

// void main() {
//   Map<String, dynamic> peakPowers = calculatePeakPower(devices, userDevices);

//   print(
//       "Sun: ${peakPowers['peakPowerSun']} W _ from: ${minutesToTime(peakPowers['peakStartSun'])} _ to: ${minutesToTime(peakPowers['peakEndSun'])}");
//   print("Devices in Sun Peak: ${peakPowers['devicesInPeakSun']}");

//   print(
//       "Night: ${peakPowers['peakPowerNight']} W _ from: ${minutesToTime(peakPowers['peakStartNight'])} _ to: ${minutesToTime(peakPowers['peakEndNight'])}");
//   print("Devices in Night Peak: ${peakPowers['devicesInPeakNight']}");

  Future<void> calculateSystem(Map<String, dynamic> body) async {
    emit(CalculateSystemLoadingState());

    final result = await Repo.calculateSolarSystem(body);

    result.fold(
        (failure) => emit(CalculateSystemErrorState(failure.errorMessege)),
        (suggestedProduct) {
      print("SUC");
      return emit(CalculateSystemSuccessState(suggestedProduct));
    });
  }

  void submitOrder(Order1 order) async {
    emit(SubmitOrderLoading());
    final result = await Repo.submitOrder(order);
    result.fold(
      (failure) => emit(SubmitOrderFailure(errMessage: failure.errorMessege)),
      (success) => emit(SubmitOrderSuccess(message: success.msg)),
    );
  }
}
 
// void main() {
//   Map<String, dynamic> peakPowers = calculatePeakPower(devices, userDevices);
//   print(
//       "Sun: ${peakPowers['peakPowerSun']} W _ from: ${minutesToTime(peakPowers['peakStartSun'])} _ to: ${minutesToTime(peakPowers['peakEndSun'])}");
//   print("Devices in Sun Peak: ${peakPowers['devicesInPeakSun']}");
//   print(
//       "Night: ${peakPowers['peakPowerNight']} W _ from: ${minutesToTime(peakPowers['peakStartNight'])} _ to: ${minutesToTime(peakPowers['peakEndNight'])}");
//   print("Devices in Night Peak: ${peakPowers['devicesInPeakNight']}");

//   print("Total Night Power: ${peakPowers['totalPowerNight']} Wh");
//   print("Devices in Total Night Power: ${peakPowers['totalDevicesNight']}");
// }