import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:stock_check/model/user_model.dart';

class SqliteDatabaseHelper {
  final String _tableName = "users";

  Future<Database> getDataBase() async {
    return openDatabase(
      join(await getDatabasesPath(), "usersDatabase.db"),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $_tableName (id TEXT PRIMARY KEY, name TEXT, tradeName TEXT, mobileNo Text, whatsAppNo Text, address Text, gstNumber Text, location Text)",
        );
      },
      version: 2,
    );
  }

  Future<int> insertUser(User user) async {
    int userId = 0;
    Database db = await getDataBase();
    await db.insert(_tableName, user.toMap()).then((value) {
      userId = value;
    });
    return userId;
  }

  Future<List<User>> getAllUsers() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> usersMaps = await db.query(_tableName);
    return List.generate(usersMaps.length, (index) {
      return User(
          id: usersMaps[index]["id"],
          name: usersMaps[index]["name"],
          tradeName: usersMaps[index]["tradeName"],
          mobileNo: usersMaps[index]["mobileNo"],
          whatsAppNo: usersMaps[index]["whatsAppNo"],
          address: usersMaps[index]["address"],
          gstNumber: usersMaps[index]["gstNumber"],
          location: usersMaps[index]["location"]);
    });
  }

  Future<User> getUser(String userId) async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> user =
        await db.rawQuery("SELECT * FROM $_tableName WHERE id = $userId");
    if (user.length == 1) {
      return User(
          id: user[0]["id"],
          name: user[0]["name"],
          tradeName: user[0]["tradeName"],
          mobileNo: user[0]["mobileNo"],
          whatsAppNo: user[0]["whatsAppNo"],
          address: user[0]["address"],
          gstNumber: user[0]["gstNumber"],
          location: user[0]["location"]);
    } else {
      return const User();
    }
  }

  /* Future<void> updateUser(String userId, String name, String imageUrl) async {
    Database db = await getDataBase();
    db.rawUpdate("UPDATE $_tableName SET name = '$name', tradeName = '$imageUrl' WHERE id = '$userId'");
  }*/
  Future<void> deleteUser(String userId) async {
    Database db = await getDataBase();
    await db.rawDelete("DELETE FROM $_tableName WHERE id = '$userId'");
  }

}
