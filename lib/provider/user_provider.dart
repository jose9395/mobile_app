


import 'package:flutter/cupertino.dart';
import 'package:stock_check/localdb/user_table.dart';
import 'package:stock_check/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  final _db =  SqliteDatabaseHelper().getAllUsers();
  bool isLoading = false;
  List<User>  _user = [];
  List<User> get allUsers => _user;


  Future<void> getAllUser() async {
    isLoading = true;
    notifyListeners();

    final response = await _db;
    _user = response;
    isLoading = false;
    notifyListeners();
  }



}