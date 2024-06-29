class MessageModel2 {
  final bool status;
  final String msg;

  MessageModel2({required this.status, required this.msg});

  factory MessageModel2.fromJson(Map<String, dynamic> json) {
    return MessageModel2(
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
