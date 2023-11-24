class ImageModel {
  String? imagePath;
  String? description;
  bool? isFavorite;

  ImageModel({
    this.imagePath,
    this.description,
    this.isFavorite = false,
  });
}
final imageModelList = [
  ImageModel(
      imagePath: 'assets/creation/preview.png',
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, essentially unchanged."),
  ImageModel(
      imagePath: 'assets/creation/preview.png',
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, essentially unchanged."),
  ImageModel(
      imagePath: 'assets/creation/preview.png',
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, essentially unchanged."),
  ImageModel(
      imagePath: 'assets/creation/preview.png',
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, essentially unchanged."),
  ImageModel(
      imagePath: 'assets/creation/preview.png',
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, essentially unchanged."),
  ImageModel(
      imagePath: 'assets/creation/preview.png',
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, essentially unchanged."),
];

class StyleModel {
  ImageModel? data;
  bool? isFavorite;
  bool? isPro;

  StyleModel({
    this.data,
    this.isFavorite,
    this.isPro,
  });
}

final styleList = [
  StyleModel(
    data: ImageModel(imagePath: "assets/styles/none.png", description: "None"),
    isFavorite: false,
    isPro: false,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style5.png", description: "Oil Painting"),
    isFavorite: false,
    isPro: false,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style2.png", description: "Watercolor"),
    isFavorite: false,
    isPro: true,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style4.png", description: "Pastel"),
    isFavorite: false,
    isPro: false,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style6.png", description: "Digital"),
    isFavorite: false,
    isPro: true,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style1.png", description: "Color Blend"),
    isFavorite: false,
    isPro: false,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style3.png", description: "Cartoon"),
    isFavorite: false,
    isPro: false,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style7.png", description: "Abstract"),
    isFavorite: false,
    isPro: false,
  ),
];

final modelList = [
  StyleModel(
    data: ImageModel(imagePath: "assets/styles/none.png", description: "None"),
    isFavorite: false,
    isPro: false,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style5.png", description: "Alchemy"),
    isFavorite: false,
    isPro: true,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style2.png", description: "Chimera"),
    isFavorite: false,
    isPro: false,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style4.png", description: "Fantasia"),
    isFavorite: false,
    isPro: false,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style6.png", description: "Enigma"),
    isFavorite: false,
    isPro: false,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style1.png", description: "Genesis"),
    isFavorite: false,
    isPro: false,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style3.png", description: "Nirvana"),
    isFavorite: false,
    isPro: false,
  ),
  StyleModel(
    data:
        ImageModel(imagePath: "assets/styles/style7.png", description: "Mira"),
    isFavorite: false,
    isPro: false,
  ),
];

final inspirationList = [
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/none.png",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, essentially unchanged."),
    isFavorite: false,
    isPro: false,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style5.png",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, essentially unchanged."),
    isFavorite: false,
    isPro: false,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style2.png",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, essentially unchanged."),
    isFavorite: false,
    isPro: true,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style4.png",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, essentially unchanged."),
    isFavorite: false,
    isPro: false,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style6.png",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, essentially unchanged."),
    isFavorite: false,
    isPro: true,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style1.png",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, essentially unchanged."),
    isFavorite: false,
    isPro: false,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style3.png",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, essentially unchanged."),
    isFavorite: false,
    isPro: false,
  ),
  StyleModel(
    data: ImageModel(
        imagePath: "assets/styles/style7.png",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy textever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, essentially unchanged."),
    isFavorite: false,
    isPro: false,
  ),
];
