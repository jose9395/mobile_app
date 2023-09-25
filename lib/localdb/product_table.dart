import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:stock_check/model/product_model.dart';

class ProductTable {
  final String _tableName = "products";

  Future<Database> getDataBase() async {
    return openDatabase(
      join(await getDatabasesPath(), "productDatabase.db"),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $_tableName (id TEXT PRIMARY KEY, category TEXT, code TEXT, brandImage Text, productName Text, description Text, size Text, mrp Text, price Text)",
        );
      },
      version: 2,
    );
  }

  Future<int> insertProduct(Product product) async {
    int productId = 0;
    Database db = await getDataBase();
    await db.insert(_tableName, product.toMap()).then((value) {
      productId = value;
    });
    return productId;
  }

  Future<List<Product>> getAllProducts() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> usersMaps = await db.query(_tableName);
    return List.generate(usersMaps.length, (index) {
      return Product(
          id: usersMaps[index]["id"],
          category: usersMaps[index]["category"],
          code: usersMaps[index]["code"],
          brandImage: usersMaps[index]["brandImage"],
          productName: usersMaps[index]["productName"],
          description: usersMaps[index]["description"],
          packageSize: usersMaps[index]["size"],
          mrp: usersMaps[index]["mrp"],
          price: usersMaps[index]["price"]);
    });
  }

  Future<Product> getProduct(String prodId) async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> user =
        await db.rawQuery("SELECT * FROM $_tableName WHERE id = $prodId");
    if (user.length == 1) {
      return Product(
          id: user[0]["id"],
          category: user[0]["category"],
          code: user[0]["code"],
          brandImage: user[0]["brandImage"],
          productName: user[0]["productName"],
          description: user[0]["description"],
          packageSize: user[0]["size"],
          mrp: user[0]["location"],
          price: user[0]["price"]);
    } else {
      return const Product();
    }
  }

  Future<void> updateProduct(String userId, String price) async {
    Database db = await getDataBase();
    db.rawUpdate(
        "UPDATE $_tableName SET price = '$price' WHERE id = '$userId'");
  }

  Future<void> deleteProduct(String productId) async {
    Database db = await getDataBase();
    await db.rawDelete("DELETE FROM $_tableName WHERE id = '$productId'");
  }
}
