import 'dart:convert';

ChatResponse chatResponseFromJson(String str) => ChatResponse.fromJson(json.decode(str));

String chatResponseToJson(ChatResponse data) => json.encode(data.toJson());

class ChatResponse {
  ChatResponse({
    this.jsonrpc,
    this.id,
    this.result,
  });

  String? jsonrpc;
  dynamic id;
  Result? result;

  factory ChatResponse.fromJson(Map<String, dynamic> json) => ChatResponse(
    jsonrpc: json["jsonrpc"],
    id: json["id"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "jsonrpc": jsonrpc,
    "id": id,
    "result": result?.toJson(),
  };
}

class Result {
  Result({
    this.jsonrpc,
    this.id,
    this.result,
  });

  String? jsonrpc;
  dynamic id;
  ResultData? result;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    jsonrpc: json["jsonrpc"],
    id: json["id"],
    result: json["result"] == null ? null : ResultData.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "jsonrpc": jsonrpc,
    "id": id,
    "result": result?.toJson(),
  };
}

class ResultData {
  ResultData({
    this.prompt,
    this.answer,
    this.responsedetail,
  });

  String? prompt;
  String? answer;
  ResponseDetail? responsedetail;

  factory ResultData.fromJson(Map<String, dynamic> json) => ResultData(
    prompt: json["prompt"],
    answer: json["answer"],
    responsedetail: json["responsedetail"] == null ? null : ResponseDetail.fromJson(json["responsedetail"]),
  );

  Map<String, dynamic> toJson() => {
    "prompt": prompt,
    "answer": answer,
    "responsedetail": responsedetail?.toJson(),
  };
}

class ResponseDetail {
  ResponseDetail({
    this.messages,
    this.messagestype,
    this.responsecode,
  });

  String? messages;
  int? messagestype;
  int? responsecode;

  factory ResponseDetail.fromJson(Map<String, dynamic> json) => ResponseDetail(
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
