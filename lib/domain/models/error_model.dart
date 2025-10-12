class ErrorModel {
  String? message;

  ErrorModel({this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = message;
    return data;
  }
}