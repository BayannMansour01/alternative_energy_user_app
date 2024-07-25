// class MyOrderResponse {
//   final bool status;
//   final String msg;
//   final List<MyOrderData> orders;

//   MyOrderResponse({
//     required this.status,
//     required this.msg,
//     required this.orders,
//   });

//   factory MyOrderResponse.fromJson(Map<String, dynamic> json) {
//     return MyOrderResponse(
//       status: json['status'],
//       msg: json['msg'],
//       orders: (json['orders'] as List)
//           .map((order) => MyOrderData.fromJson(order))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'msg': msg,
//       'orders': orders.map((order) => order.toJson()).toList(),
//     };
//   }
// }

class MyOrderData {
  final MyOrder order;
  // final List<Appointment> appointment;

  MyOrderData({
    required this.order,
    // required this.appointment,
  });

  factory MyOrderData.fromJson(Map<String, dynamic> json) {
    return MyOrderData(
      order: MyOrder.fromJson(json['order']),
      // appointment: (json['appointment'] )
      //     .map((appt) => Appointment.fromJson(appt))
      //     .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order': order.toJson(),
      // 'appointment': appointment.map((appt) => appt.toJson()).toList(),
    };
  }
}

class MyOrder {
  final int id;
  final String image;
  final String desc;
  final String? totalVoltage;
  final String? chargeHours;
  final String? location;
  final String state;
  final int typeId;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  MyOrder({
    required this.id,
    required this.image,
    required this.desc,
    this.totalVoltage,
    this.chargeHours,
    this.location,
    required this.state,
    required this.typeId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyOrder.fromJson(Map<String, dynamic> json) {
    return MyOrder(
      id: json['id'],
      image: json['image'] ?? " ",
      desc: json['desc'] ?? " ",
      totalVoltage: json['totalVoltage'] ?? " ",
      chargeHours: json['chargeHours'] ?? " ",
      location: json['location'] ?? " ",
      state: json['state'],
      typeId: json['type_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'desc': desc,
      'totalVoltage': totalVoltage,
      'chargeHours': chargeHours,
      'location': location,
      'state': state,
      'type_id': typeId,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

// class Appointment {
//   final String startTime;

//   Appointment({
//     required this.startTime,
//   });

//   factory Appointment.fromJson(Map<String, dynamic> json) {
//     return Appointment(
//       startTime: json['start_time'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'start_time': startTime,
//     };
//   }
// }
