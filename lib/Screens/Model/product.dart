class Product {
  int productId;
  double price;
  int quantity;
  double mrp;
  String theme;
  double weight;
  String vendor;

  Product({
    required this.productId,
    required this.price,
    required this.quantity,
    required this.mrp,
    required this.theme,
    required this.weight,
    required this.vendor,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      mrp: json['mrp'].toDouble(),
      theme: json['theme'],
      weight: json['weight'].toDouble(),
      vendor: json['vendor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'price': price,
      'quantity': quantity,
      'mrp': mrp,
      'theme': theme,
      'weight': weight,
      'vendor': vendor,
    };
  }
}
