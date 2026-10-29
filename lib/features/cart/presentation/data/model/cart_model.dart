class CartModel {
  String? id;
  String? name;
  double? price;
  String? image;
  int? quantity;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.image,
    this.quantity,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name'] ?? json['title']; 
    price = (json['price'] as num?)?.toDouble();
    image = json['image'] ?? json['thumbnail'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['quantity'] = quantity;
    return data;
  }
}