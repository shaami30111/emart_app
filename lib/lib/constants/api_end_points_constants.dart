class ApiEndPoints {
  ApiEndPoints._();

  /// * To Generate Art POST METHOD
  static const artGenBaseUrl = 'http://theitzon.nayatel.net:8090';

  /// * To Fetch All Styles GET METHOD
  static const getAllStylesBaseUrl =
      'http://208.73.202.133/Art_Styles_Images/Art_images.json';

  /// * To Fetch All Models GET METHOD
  static const getAllModelsBaseUrl =
      'http://192.168.18.230:5108/display_art_json/model.json/';

  /// * To Fetch All Inspirations GET METHOD
  static const getAllInspirationsBaseUrl =
      'http://192.168.18.230:5108/display_art_json/inspiration_images/image_info.json/';

  /// * To Set Model for artGenerator POST METHOD
  static const modelSelectionBaseUrl =
      'http://theitzon.nayatel.net:8090/sdapi/v1/options';

  /// * To Fetch Model Images BASE URL
  static const modelImagePathBaseUrl =
      'http://192.168.18.230:5108/display_art_image/';

  /// * To Fetch Inspiration Images BASE URL
  static const inspirationImagePathBaseUrl =
      'http://192.168.18.230:5108/display_art_image/inspiration_images/';
}
