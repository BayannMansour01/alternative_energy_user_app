class MaintenanceRequest {
  int? typeId;
  List<String>? images;
  String? desc;

  MaintenanceRequest({this.typeId, this.images, this.desc});

  MaintenanceRequest.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    images = json['images'].cast<String>();
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_id'] = this.typeId;
    data['images'] = this.images;
    data['desc'] = this.desc;
    return data;
  }
}
