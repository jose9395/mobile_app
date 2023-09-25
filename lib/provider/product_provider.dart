import 'package:flutter/cupertino.dart';
import 'package:stock_check/localdb/product_table.dart';
import 'package:stock_check/model/product_model.dart';

class ProductProvider extends ChangeNotifier {

  final _db =  ProductTable().getAllProducts();
  bool isLoading = false;
  List<Product>  _product = [];
  List<Product> get allProduct => _product;

 Future<Product>? product;

  Future<void> getAllProduct() async {
    isLoading = true;
    notifyListeners();

    final response = await _db;
    _product = response;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getProduct(String prodId) async {
    isLoading = true;
    notifyListeners();

    product = ProductTable().getProduct(prodId);
    isLoading = false;
    notifyListeners();
  }


}