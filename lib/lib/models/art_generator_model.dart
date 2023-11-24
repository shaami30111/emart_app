class ArtGeneratorModel {
  String prompt;
  List<String> styles;
  int seed;
  int steps;
  int width;
  int height;
  int batchSize;
  int cfgScale;

  ArtGeneratorModel({
    required this.prompt,
    required this.styles,
    required this.seed,
    required this.steps,
    required this.width,
    required this.height,
    required this.batchSize,
    required this.cfgScale,
  });

  Map<String, dynamic> toJson() {
    return {
      "prompt": prompt,
      "styles": styles,
      "seed": seed,
      "steps": steps,
      "width": width,
      "height": height,
      "batchSize": batchSize,
      "cfgScale": cfgScale,
    };
  }
}
