import 'package:flutter/cupertino.dart';
import 'package:stock_check/localdb/user_table.dart';
import 'package:stock_check/model/user_model.dart';

class UserProvider extends ChangeNotifier {

  List<User>  _user = [];
  List<User> get allUsers => _user;


  Future<void> getAllUser() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final _db =  SqliteDatabaseHelper().getAllUsers();
      final response = await _db;
      _user = response;
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to fetch items: $error'); // Throw an exception in case of an error
    }
  }

  Future<void> deleteUser(String userId) async{
    SqliteDatabaseHelper().deleteUser(userId);
    getAllUser();
    notifyListeners();
  }



}