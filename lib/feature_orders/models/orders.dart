class Orders {
    Orders({
        this.id,
        required this.description,
        required this.totalPrice,
        required this.quantity,
        required this.paymentMethod,
        required this.saleId,
        required this.orderedBy,
        required this.acceptedBy,
        required this.orderedDate,
        required this.status,
    });
    int? id;
    final String? description;
    final double? totalPrice;
    final int? quantity;
    final String? paymentMethod;
    final int? saleId;
    final int? orderedBy;
    final int? acceptedBy;
    final int? orderedDate;
    final String? status;

    factory Orders.fromJson(Map<String, dynamic> json){ 
        return Orders(
            id: json["id"],
            description: json["description"],
            totalPrice: json["totalPrice"],
            quantity: json["quantity"],
            paymentMethod: json["paymentMethod"],
            saleId: json["saleId"],
            orderedBy: json["orderedBy"],
            acceptedBy: json["acceptedBy"],
            orderedDate: json["orderedDate"],
            status: json["status"],
        );
    }

    Map<String, dynamic> toJson() => {
        "description": description,
        "totalPrice": totalPrice,
        "quantity": quantity,
        "paymentMethod": paymentMethod,
        "saleId": saleId,
        "orderedBy": orderedBy,
        "acceptedBy": acceptedBy,
        "orderedDate": orderedDate,
        "status": status,
    };

    @override
    String toString(){
        return "$description, $totalPrice, $quantity, $paymentMethod, $saleId, $orderedBy, $acceptedBy, $orderedDate, $status, ";
    }
}
