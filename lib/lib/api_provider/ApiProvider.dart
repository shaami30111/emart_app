import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/art_image.dart';

class ApiProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  List<ArtImage> _artImages = [];

  List<ArtImage> get artImages => _artImages;

  Future<void> fetchArtImages() async {
    try {
      final response = await _dio
          .get('http://208.73.202.133/Art_Styles_Images/Art_images.json');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        _artImages = jsonList.map((json) => ArtImage.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load art images');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
