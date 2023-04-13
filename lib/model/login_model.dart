// To parse this JSON data, do
//
//     final logInModel = logInModelFromJson(jsonString);

import 'dart:convert';

LogInModel logInModelFromJson(String str) => LogInModel.fromJson(json.decode(str));

String logInModelToJson(LogInModel data) => json.encode(data.toJson());

class LogInModel {
  LogInModel({
    this.apiresponse,
  });

  Apiresponse? apiresponse;

  factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
    apiresponse: json["apiresponse"] == null ? null : Apiresponse.fromJson(json["apiresponse"]),
  );

  Map<String, dynamic> toJson() => {
    "apiresponse": apiresponse?.toJson(),
  };
}

class Apiresponse {
  Apiresponse({
    this.dataArray,
    this.data,
    this.timestamp,
  });

  dynamic dataArray;
  Data? data;
  int? timestamp;

  factory Apiresponse.fromJson(Map<String, dynamic> json) => Apiresponse(
    dataArray: json["dataArray"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "dataArray": dataArray,
    "data": data?.toJson(),
    "timestamp": timestamp,
  };
}

class Data {
  Data({
    this.id,
    this.username,
    this.email,
    this.token,
  });

  int? id;
  dynamic username;
  String? email;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "token": token,
  };
}
