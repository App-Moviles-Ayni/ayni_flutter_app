class Products {
  final int id;
  final String name;
  final String description;
  final String recommendedCultivationDistance;
  final String recommendedCultivationDepth;
  final String recommendedGrowingClimate;
  final String recommendedSoilType;
  final String recommendedGrowingSeason;
  final String imageUrl;
  final int userId;

  const Products(
      {required this.id,
      required this.name,
      required this.description,
      required this.recommendedCultivationDistance,
      required this.recommendedCultivationDepth,
      required this.recommendedGrowingClimate,
      required this.recommendedSoilType,
      required this.recommendedGrowingSeason,
      required this.imageUrl,
      required this.userId});

  Products.fromJson(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        description = map["description"],
        recommendedCultivationDistance = map["recommendedCultivationDistance"],
        recommendedCultivationDepth = map["recommendedCultivationDepth"],
        recommendedGrowingClimate = map["recommendedGrowingClimate"],
        recommendedSoilType = map["recommendedSoilType"],
        recommendedGrowingSeason = map["recommendedGrowingSeason"],
        imageUrl = map["imageUrl"],
        userId = map["userId"];
}