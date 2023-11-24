class Temperatures {
  List<String> images;

  Temperatures({
    required this.images,
  });

  factory Temperatures.fromJson(Map<String, dynamic> json) {
    return Temperatures(
      images: List<String>.from(json['images']),
    );
  }
}
