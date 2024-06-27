class Transaction {
  final int id;
  final String costName;
  final String date;
  final String description;
  final String transactionType;
  final double price;
  final String quantity;
  final int userId;

  const Transaction({
    required this.id,
    required this.costName,
    required this.date,
    required this.description,
    required this.transactionType,
    required this.price,
    required this.quantity,
    required this.userId,
  });

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        costName = json["costName"],
        date = json["date"],
        description = json["description"],
        transactionType = json["transactionType"],
        price = json["price"],
        quantity = json["quantity"],
        userId = json["userId"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "costName": costName,
        "date": date,
        "description": description,
        "transactionType": transactionType,
        "price": price,
        "quantity": quantity,
        "userId": userId,
      };
}
