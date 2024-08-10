class Order1 {
  final int typeId;
  final String location;
  final List<ProductOrder> products;

  Order1({
    required this.typeId,
    required this.location,
    required this.products,
  });
  Map<String, dynamic> toJson() {
    return {
      'type_id': typeId,
      'location': location,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

class ProductOrder {
  final int id;
  final int amount;
  final String name;
  final int price;
  final String imageUrl;

  ProductOrder({
    required this.price,
    required this.id,
    required this.amount,
    required this.name,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
    };
  }
}
