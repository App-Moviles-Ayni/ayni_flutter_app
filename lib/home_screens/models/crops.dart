class Crops {
  final int id;
  final String name;
  final bool pickUpWeed;
  final bool fertilizeCrop;
  final bool oxygenateCrop;
  final bool makeCropLine;
  final bool makeCropHole;
  final int wateringDays;
  final int pestCleanupDays;
  final int productId;
  final int userId;

  const Crops(
      {required this.id,
      required this.name,
      required this.pickUpWeed,
      required this.fertilizeCrop,
      required this.oxygenateCrop,
      required this.makeCropLine,
      required this.makeCropHole,
      required this.wateringDays,
      required this.pestCleanupDays,
      required this.productId,
      required this.userId});

  Crops.fromJson(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        pickUpWeed = map["pickUpWeed"],
        fertilizeCrop = map["fertilizeCrop"],
        oxygenateCrop = map["oxygenateCrop"],
        makeCropLine = map["makeCropLine"],
        makeCropHole = map["makeCropHole"],
        wateringDays = map["wateringDays"],
        pestCleanupDays = map["pestCleanupDays"],
        productId = map["productId"],
        userId = map["userId"];

}