class ModelBaseResponse {
  String title;
  String modelName;
  String filename;
  bool proUserAccess;
  bool isFavorite = false;

  ModelBaseResponse({
    required this.title,
    required this.modelName,
    required this.filename,
    required this.proUserAccess,
    required this.isFavorite,
  });

  factory ModelBaseResponse.fromJson(Map<String, dynamic> json) {
    return ModelBaseResponse(
      title: json['title'] ?? '',
      modelName: json['model_name'] ?? '',
      filename: json['image_path'] ?? '',
      proUserAccess: json['pro_user_access'] ?? false,
      isFavorite: false,
    );
  }
}
