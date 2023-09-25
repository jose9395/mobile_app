import 'package:flutter/material.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/app_color.dart';
import 'package:stock_check/const/route_name.dart';
import 'package:stock_check/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:stock_check/screens/list_items/user-list-item.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        Provider.of<UserProvider>(context, listen: false).getAllUser();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Consumer<UserProvider>(
        builder: (context, value, child) {
          if(value.isLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(value.allUsers.isEmpty){
            return const Center(
              child: Text("No Users Available"),
            );
          } else {
           final user =  value.allUsers;
           return ListView.builder(
               itemCount: user.length,
               itemBuilder: (context, index){
                 return UserListItem(
                  name: user[index].name,
                  mobileNo: user[index].mobileNo,
                   address: user[index].address,
                   userId: user[index].id,
                 );
               });
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: green33,
        onPressed: (){
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
