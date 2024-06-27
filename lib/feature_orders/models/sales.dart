class Sales {
  Sales({
    required this.name,
    required this.description,
    required this.unitPrice,
    required this.quantity,
    required this.imageUrl,
    required this.userId,
  });

  final String? name;
  final String? description;
  final double? unitPrice;
  final int? quantity;
  final String? imageUrl;
  final int? userId;

  Sales.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        description = json["description"],
        unitPrice = json["unitPrice"],
        quantity = json["quantity"],
        imageUrl = json["imageUrl"],
        userId = json["userId"];

  get id => null;

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "unitPrice": unitPrice,
        "quantity": quantity,
        "imageUrl": imageUrl,
        "userId": userId,
      };

  @override
  String toString() {
    return "$name, $description, $unitPrice, $quantity, $imageUrl, $userId, ";
  }
}
