///----For ai art styles
class ArtImage {
  String? name;
  String? thumbnail;
  List<Style?>? styles;

  ArtImage({this.name, this.thumbnail, this.styles});

  ArtImage.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    thumbnail = json['thumbnail'];
    if (json['Styles'] != null) {
      styles = <Style>[];
      json['Styles'].forEach((v) {
        styles!.add(Style.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    data['Styles'] =
        // ignore: prefer_null_aware_operators
        styles != null ? styles!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}

class AiArtStylesBaseResponse {
  ArtImage? artImage;

  AiArtStylesBaseResponse({this.artImage});

  AiArtStylesBaseResponse.fromJson(Map<String, dynamic> json) {
    artImage = json['Art_Image'] != null
        ? ArtImage?.fromJson(json['Art_Image'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Art_Image'] = artImage?.toJson();
    return data;
  }
}

class Style {
  String? index;
  String? name;
  String? dimension;
  String? pro;
  String? coin;
  String? thumb;
  bool? isFavorite;
  String? isPro;

  Style(
      {this.index,
      this.name,
      this.dimension,
      this.pro,
      this.coin,
      this.thumb,
      this.isFavorite,
      this.isPro});

  Style.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    name = json['name'];
    dimension = json['dimension'];
    pro = json['pro'];
    coin = json['coin'];
    thumb = json['thumb'];
    isFavorite = json['isFavorite'] ?? false;
    isPro = json['pro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['index'] = index;
    data['name'] = name;
    data['dimension'] = dimension;
    data['pro'] = pro;
    data['coin'] = coin;
    data['thumb'] = thumb;
    data['isFavorite'] = isFavorite;
    data['pro'] = isPro;
    return data;
  }
}
