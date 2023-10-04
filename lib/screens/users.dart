import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/app_text_style.dart';
import 'package:stock_check/const/route_name.dart';
import 'package:stock_check/provider/user_provider.dart';
import 'package:stock_check/screens/list_items/user-list-item.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false).getAllUser(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : Consumer<UserProvider>(
                    child: Center(
                      child: Text(
                        'No products added',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.content,
                      ),
                    ),
                    builder: (context, userProvider, child) =>
                        userProvider.allUsers.isEmpty
                            ? child!
                            : ListView.builder(
                                itemCount: userProvider.allUsers.length,
                                itemBuilder: (context, index) {
                                  final user = userProvider.allUsers[index];
                                  return UserListItem(
                                    name: user.name,
                                    mobileNo: user.mobileNo,
                                    address: user.address,
                                    whatsappno: user.whatsAppNo,
                                    gstno: user.gstNumber,
                                    tradeName: user.tradeName,
                                  );
                                },
                              ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: green33,
        onPressed: () {
          Navigator.of(context).pushNamed(RouteName.adduser);
        },
        child: Icon(
          Icons.add,
          color: white,
          size: 30 * SizeConfig.widthMultiplier!,
        ),
      ),
    );
  }
}
