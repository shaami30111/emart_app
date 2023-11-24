import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:ai_art_gen/constants/api_end_points_constants.dart';
import 'package:ai_art_gen/database/database.dart';
import 'package:ai_art_gen/models/image_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Utils/common_functions.dart';
import '../main.dart';
import '../models/art_image.dart';
import '../models/inspiration_base_response.dart';
import '../models/models_base_response.dart';

class SelectionProvider with ChangeNotifier {
  final Dio _dio = Dio();

  Future<void> applyingArtModel(String selectedModel) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"sd_model_checkpoint": selectedModel});
      var dio = Dio();
      var response = await dio.request(
        ApiEndPoints.modelSelectionBaseUrl,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
        onSendProgress: (int sent, int total) {
          if (kDebugMode) {
            print('Sent: $sent, Total: $total');
          }
        },
        onReceiveProgress: (int received, int total) {
          if (kDebugMode) {
            print('Received: $received, Total: $total');
          }
        },
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("applyingModel${json.encode(response.data)}");
        }
      } else {
        if (kDebugMode) {
          print(response.statusMessage);
        }
      }
      notifyListeners();
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  final List<Style> _styles = [];

  List<Style> get stylesImages => _styles;

  Future<void> fetchArtImages() async {
    try {
      final response = await _dio.get(ApiEndPoints.getAllStylesBaseUrl);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        AiArtStylesBaseResponse rootInstance =
            AiArtStylesBaseResponse.fromJson(responseData);
        // _styles.clear();
        if (rootInstance.artImage != null &&
            rootInstance.artImage?.styles != null) {
          _styles.clear();
          rootInstance.artImage?.styles?.forEach((style) async {
            String imagePath =
                'http://208.73.202.133/Art_Styles_Images/${style?.thumb}';
            bool isFavorite = await db?.isFavorite(imagePath) ?? false;
            _styles.add(Style(
                index: style?.index,
                name: style?.name,
                dimension: style?.dimension,
                pro: style?.pro,
                coin: style?.coin,
                thumb: imagePath,
                isFavorite: isFavorite,
                isPro: style?.isPro));
          });
        }
        notifyListeners();
      } else {
        throw Exception('Failed to load art images');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
    notifyListeners();
  }

  final List<ModelBaseResponse> _models = [];

  List<ModelBaseResponse> get modelsImages => _models;

  void fetchModelsDataList() async {
    try {
      var response = await _dio.request(
        ApiEndPoints.getAllModelsBaseUrl,
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonResponseList = response.data;
        try {
          List<ModelBaseResponse> modelResponses = jsonResponseList
              .map((jsonResponse) => ModelBaseResponse.fromJson(jsonResponse))
              .toList();
          for (var element in modelResponses) {
            String modifiedPath =
                "${ApiEndPoints.modelImagePathBaseUrl}${element.filename}";
            bool isFavorite = await db?.isModelFavorite(modifiedPath) ?? false;
            _models.add(ModelBaseResponse(
                title: element.title,
                modelName: element.modelName,
                filename: modifiedPath,
                proUserAccess: element.proUserAccess,
                isFavorite: isFavorite));
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error parsing response: $e');
          }
        }
      } else {
        if (kDebugMode) {
          print(response.statusMessage);
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }

    notifyListeners();
  }

  final List<InspirationBaseResponse> _inspirations = [];

  List<InspirationBaseResponse> get inspirations => _inspirations;

  void fetchInspirationsDataList() async {
    const String apiUrl = ApiEndPoints.getAllInspirationsBaseUrl;
    try {
      var response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponseList = response.data;
        try {
          List<InspirationBaseResponse> modelResponses = jsonResponseList
              .map((jsonResponse) =>
                  InspirationBaseResponse.fromJson(jsonResponse))
              .take(30)
              .toList();
          if (kDebugMode) {
            print("inspirationLength${jsonResponseList.length}");
          }
          _inspirations.clear();
          for (var element in modelResponses) {
            String modifiedPath =
                "${ApiEndPoints.inspirationImagePathBaseUrl}${element.path}";
            bool isFavorite =
                await db?.isInspirationFavorite(modifiedPath) ?? false;
            _inspirations.add(InspirationBaseResponse(
              command: element.command,
              path: modifiedPath,
              pro_user_access: element.pro_user_access,
              isFavorite: isFavorite,
            ));
          }
          notifyListeners();
        } catch (e) {
          notifyListeners();
          if (kDebugMode) {
            print('Error parsing response: $e');
          }
        }
      } else {
        if (kDebugMode) {
          print(response.statusMessage);
        }
        notifyListeners();
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
      notifyListeners();
    }
    notifyListeners();
  }

  final List<ImageModel> _myCreations = [];

  List<ImageModel> get myCreations => _myCreations;

  void fetchAllCreatedFiles() async {
    try {
      dynamic result = await platform.invokeMethod('fetchAllCreatedFiles');
      if (result is List) {
        List<String> stringList = result.cast<String>();
        stringList = stringList.where((filePath) {
          File file = File(filePath);
          return file.existsSync();
        }).toList();
        _myCreations.clear();
        if (kDebugMode) {
          print("resultList$stringList");
        }
        if (kDebugMode) {
          print("resultList${stringList.length}");
        }
        var reversedList = stringList.toList()..sort((a, b) => b.compareTo(a));
        await Future.wait(reversedList.map((item) async {
          try {
            _myCreations.add(ImageModel(
                imagePath: item,
                description:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, essentially unchanged."));
          } catch (e) {
            if (kDebugMode) {
              print('Error fetching creation date for $item: $e');
            }
          }
        }).toList());
      } else {
        if (kDebugMode) {
          print('Error: Result is not a List');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
    notifyListeners();
  }

  final List<InspirationFavoriteData> _favInspirations = [];

  List<InspirationFavoriteData> get favInspirations => _favInspirations;

  Future<void> fetchFavInspiration() async {
    final List<InspirationFavoriteData>? inspirationFavorite =
        await db?.getAllInspiration();
    debugPrint("InspirationFavoriteLength${inspirationFavorite?.length}");
    _favInspirations.clear();
    if (inspirationFavorite?.isNotEmpty ?? false) {
      _favInspirations.addAll(inspirationFavorite!);
    }
    notifyListeners();
  }

  // inspirationFavorites

  int? inpIndex;

  inspirIndex(entry) {
    inpIndex = inspirations.indexWhere((element) => element.path == entry.path);
    notifyListeners();
  }

  removeInspir(element) {
    var index = inspirations.indexWhere(
      (e) => e.path == element.path,
    );
    inspirations[index].isFavorite = false;
    notifyListeners();
  }

  addInspir(element) {
    var index = inspirations.indexWhere(
      (e) => e.path == element.path,
    );
    inspirations[index].isFavorite = true;
    notifyListeners();
  }

  // textfield checks

  bool editingText = false;

  changeEdit(value) {
    editingText = value;
    notifyListeners();
  }

  // try this provider

  final promptTextController = TextEditingController();

  setTryPrompt(prompt) {
    promptTextController.text = prompt;
    notifyListeners();
  }

  textClear() {
    promptTextController.clear();
    notifyListeners();
  }

  var dialog = '';

  addDialog(value) {
    dialog = value;
    notifyListeners();
  }

  List generated = [];
  var generatePreview = '';

  addGenerated(imagePath) {
    if (generated.isEmpty) {
      generatePreview = imagePath;
    }
    generated.add(imagePath);
    notifyListeners();
  }

  ///---selected Prompt

  var generatePrompt = '';

  addSelectedPrompt(prompt) {
    generatePrompt = prompt;
    notifyListeners();
  }

  ///----generated more results
  List generatedMore = [];
  var generateMorePreview = '';

  addGeneratedMore(imagePath) {
    if (generateMorePreview.isEmpty) {
      generateMorePreview = imagePath;
    }
    generatedMore.add(imagePath);
    notifyListeners();
  }

  void clearGeneratedMore() {
    generatedMore.clear();
    generateMorePreview = '';
    notifyListeners();
  }

  var promptMain = '';

  addPrompt(value) {
    promptMain = value;
    notifyListeners();
  }

// cancel api token

  CancelToken cancelApi = CancelToken();

  newToken() {
    cancelApi = CancelToken();
    notifyListeners();
  }

  cancelApiRequest() {
    cancelApi.cancel();
    notifyListeners();
  }

//prompt  history model list
  // List<Map<String, dynamic>> history = [];

  // addHistory(prompt, time) {
  //   if (history.isEmpty) {
  //     history.add({
  //       "prompt": prompt,
  //       "time": time,
  //     });
  //   } else {
  //     if (!history.any((element) => element["prompt"] == prompt)) {
  //       history.add({
  //         "prompt": prompt,
  //         "time": time,
  //       });
  //     }
  //   }

  //   notifyListeners();
  // }

  // removeHistory(index) {
  //   history.removeAt(index);
  //   notifyListeners();
  // }

// slider values
  double stepsValue = 2;

  changeStep(value) {
    stepsValue = value;
    notifyListeners();
  }

  double gfsValue = 3;

  changeGFS(value) {
    gfsValue = value;
    notifyListeners();
  }

// advanced number images
  int numSelected = 0;

  changeNumSelect(index) {
    numSelected = index;
    notifyListeners();
  }

  // advanced number images
  String batchSize = "6";

  setBatchSize(index) {
    batchSize = index;
    notifyListeners();
  }

  // advanced number images
  String negativeDefaultText =
      "Please ensure that all images are family-friendly, contain no nudity, and are safe for work environments. Exclude any adult themes or content that would not be appropriate for all audiences.";
  String negativePrompt = "";

  setNegativePrompt(String index) {
    negativePrompt = "$negativeDefaultText, $index";
    notifyListeners();
  }

  /// * Ratio Value In Whole Project
  int selectedRatio = 0;

  changeSelectedRatio(index) {
    selectedRatio = index;
    notifyListeners();
  }

  Map<String, int> selectedRatioMap = {'width': 768, 'height': 768};

  void changeSelectedRatioMap(int width, int height) {
    selectedRatioMap['width'] = width;
    selectedRatioMap['height'] = height;
    notifyListeners();
  }

  String selectedStyle = "";

  void changeSelectedStyle(selectedStyleByUser) {
    selectedStyle = selectedStyleByUser;
    notifyListeners();
  }

  var glowStyle = 'None';

  switchGlow(newGlow) {
    glowStyle = newGlow;
    notifyListeners();
  }

  int selected = 0;

  changeSelected(index) {
    selected = index;
    notifyListeners();
  }

  String selectedM = "";

  changeSelectedM(newM) {
    selectedM = newM;
    notifyListeners();
  }

  List<bool> selection = [
    false,
    true,
    false,
  ];

  int proSelection = 1;

  bool genDiscount = false;

  int clickGen = 0;

  changeProSelection(int index) {
    proSelection = index;
    notifyListeners();
  }

  addClick() {
    clickGen++;
    notifyListeners();
  }

  resetDiscount() {
    genDiscount = false;
    notifyListeners();
  }

  setDiscountGen() {
    if (clickGen == 3) {
      genDiscount = true;
    }

    notifyListeners();
  }

  resetClick() {
    clickGen = 0;
    notifyListeners();
  }

  setType(int index) {
    for (int i = 0; i < selection.length; i++) {
      selection[i] = false;
    }
    selection[index] = true;
    changeProSelection(index);
    notifyListeners();
  }

// model in advanced
  List<StyleModel> favModel = [
    StyleModel(
      data:
          ImageModel(imagePath: "assets/styles/none.png", description: "None"),
      isFavorite: false,
      isPro: false,
    ),
  ];

  addModel(index) {
    modelsImages[index].isFavorite = true;

    notifyListeners();
  }

  removeModel(name) {
    var model = modelsImages.firstWhere((element) => element.modelName == name);
    model.isFavorite = false;
    notifyListeners();
  }

  // List<Style> favStyle = [];

  addStyle(index) {
    stylesImages[index].isFavorite = true;
    notifyListeners();
  }

  removeStyle(name) {
    var style = stylesImages.firstWhere((element) => element.name == name);
    style.isFavorite = false;
    notifyListeners();
  }

  List<ImageModel> favorites = [];

  addFav(ImageModel data) {
    favorites.add(data);
    int index = inspirationList
        .indexWhere((element) => element.data!.imagePath == data.imagePath);
    inspirationList[index].isFavorite = true;
    notifyListeners();
  }

  removeFav(ImageModel data) {
    favorites.remove(data);
    int index = inspirationList
        .indexWhere((element) => element.data!.imagePath == data.imagePath);
    inspirationList[index].isFavorite = false;
    notifyListeners();
  }

  initialize() {
    selection = [
      false,
      true,
      false,
    ];

    proSelection = 1;
    generatePreview = '';
    promptMain = '';
    generated.clear();
    editingText = false;
  }
}
