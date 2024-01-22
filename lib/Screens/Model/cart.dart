

class CartItem {
  int? id;
  int product_id;
  double price;
  int quantity;
  String image;
  String title;
  double mrp;
  String theme;
  String weight;
  String vendor;

  CartItem({
    this.id,
    required this.product_id,
    required this.price,
    required this.quantity,
    required this.image,
    required this.title,
    required this.mrp,
    required this.theme,
    required this.weight,
    required this.vendor,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': product_id,
      'price': price,
      'quantity': quantity,
      'image': image,
      'title': title,
      'mrp': mrp,
      'theme': theme,
      'weight': weight,
      'vendor': vendor,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      product_id: map['product_id'],
      price: map['price'],
      quantity: map['quantity'],
      image: map['image'],
      title: map['title'],
      mrp: map['mrp'],
      theme: map['theme'],
      weight: map['weight'],
      vendor: map['vendor'],
    );
  }

}

Map<String, dynamic> itemData = {
  'id': 'id',
  'product_id': 'product_id',
  'price': 'price',
  'quantity': "quantity",
  'image': "image",
  'title': "title",
  'mrp': "mrp",
  'theme': "theme",
  'vendor': "vendor",
};

CartItem cartItem = CartItem.fromMap(itemData);
