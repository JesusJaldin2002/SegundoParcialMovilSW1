// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    int userId;
    String email;
    String token;
    String modelName;
    Responsedetail responsedetail;

    User({
        required this.userId,
        required this.email,
        required this.token,
        required this.modelName,
        required this.responsedetail,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        email: json["email"],
        token: json["token"],
        modelName: json["model_name"],
        responsedetail: Responsedetail.fromJson(json["responsedetail"]),
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "email": email,
        "token": token,
        "model_name": modelName,
        "responsedetail": responsedetail.toJson(),
    };
}

class Responsedetail {
    String messages;
    int messagestype;
    int responsecode;

    Responsedetail({
        required this.messages,
        required this.messagestype,
        required this.responsecode,
    });

    factory Responsedetail.fromJson(Map<String, dynamic> json) => Responsedetail(
        messages: json["messages"],
        messagestype: json["messagestype"],
        responsecode: json["responsecode"],
    );

    Map<String, dynamic> toJson() => {
        "messages": messages,
        "messagestype": messagestype,
        "responsecode": responsecode,
    };
}
