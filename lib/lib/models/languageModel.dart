import '../constants/text_constants.dart';

class LanguageModel {
  String? name;
  String? image;

  LanguageModel({this.image, this.name});
}

final languageModelList = [
  LanguageModel(name: langEng, image: 'assets/Language_Selection/English.png'),
  LanguageModel(name: langChi, image: 'assets/Language_Selection/Chinese.png'),
  LanguageModel(name: langAra, image: 'assets/Language_Selection/Arabic.png'),
  LanguageModel(name: langHin, image: 'assets/Language_Selection/Hindi.png'),
  LanguageModel(name: langFre, image: 'assets/Language_Selection/French.png'),
  LanguageModel(name: langTur, image: 'assets/Language_Selection/Turkish.png'),
  LanguageModel(name: langGer, image: 'assets/Language_Selection/German.png'),
];
