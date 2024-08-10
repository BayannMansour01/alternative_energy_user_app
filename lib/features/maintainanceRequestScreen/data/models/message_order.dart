class OrderMessageModel {
  final bool status;
  final String msg;

  OrderMessageModel({required this.status, required this.msg});

  factory OrderMessageModel.fromJson(Map<String, dynamic> json) {
    return OrderMessageModel(
      status: json['status'],
      msg: json['msg'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg,
    };
  }
}
