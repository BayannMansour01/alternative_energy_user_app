import 'package:alternative_energy_user_app/features/homepage/data/models/pivot_model.dart';
import 'package:alternative_energy_user_app/features/homepage/data/models/product_model.dart';

class System {
  int id;
  String name;
  String desc;
  DateTime createdAt;
  DateTime updatedAt;
  List<ProductForProposedSystem> products;

  System({
    required this.id,
    required this.name,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
    required this.products,
  });

  factory System.fromJson(Map<String, dynamic> json) {
    var productsList = json['products'] as List;
    List<ProductForProposedSystem> products =
        productsList.map((i) => ProductForProposedSystem.fromJson(i)).toList();

    return System(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      products: products,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
