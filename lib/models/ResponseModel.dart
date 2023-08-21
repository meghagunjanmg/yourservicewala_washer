class ResponseModel {
  int? status;
  String? description;

  ResponseModel({this.status, this.description});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['Description'] = this.description;
    return data;
  }
}