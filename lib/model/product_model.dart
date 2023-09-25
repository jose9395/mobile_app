class Product {
  final String? id;
  final String? category;
  final String? code;
  final String? brandImage;
  final String? productName;
  final String? description;
  final String? packageSize;
  final String? mrp;
  final String? price;

  const Product(
      {this.id,
      this.category,
      this.code,
      this.brandImage,
      this.productName,
      this.description,
      this.packageSize,
      this.mrp,
      this.price});

  factory Product.fromMap(Map<String, dynamic> json) => Product(
      id: json["id"],
      category: json["category"],
      code: json["code"],
      brandImage: json["brandImage"],
      productName: json["productName"],
      description: json["description"],
      packageSize: json["size"],
      mrp: json["mrp"],
      price: json["price"]);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'code': code,
      'brandImage': brandImage,
      'productName': productName,
      'description': description,
      'size': packageSize,
      'mrp': mrp,
      'price':price
    };
  }

}
