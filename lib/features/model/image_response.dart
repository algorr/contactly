class ImageResponse {
  ImageResponse({
    required this.success,
    required this.messages,
    required this.data,
    required this.status,
  });

  final bool? success;
  final dynamic messages;
  final ImageData? data;
  final int? status;

  factory ImageResponse.fromJson(Map<String, dynamic> json) {
    return ImageResponse(
      success: json["success"],
      messages: json["messages"],
      data: json["data"] == null ? null : ImageData.fromJson(json["data"]),
      status: json["status"],
    );
  }
}

class ImageData {
  ImageData({
    required this.imageUrl,
  });

  final String? imageUrl;

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      imageUrl: json["imageUrl"],
    );
  }
}
