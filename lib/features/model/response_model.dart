import 'data_model.dart';

class Response {
  Response({
    required this.success,
    required this.messages,
    required this.data,
  });

  final bool? success;
  final dynamic messages;
  final Data? data;

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      success: json["success"],
      messages: json["messages"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}
