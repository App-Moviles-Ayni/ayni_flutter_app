class SalesResponse {
    SalesResponse({
        required this.id,
    });

    final int? id;

    factory SalesResponse.fromJson(Map<String, dynamic> json){ 
        return SalesResponse(
            id: json["id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
    };

    @override
    String toString(){
        return "$id, ";
    }
}
