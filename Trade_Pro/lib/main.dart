import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stock_check/config/size_config.dart';
import 'package:stock_check/const/route_name.dart';
import 'package:stock_check/routes/routes.dart';


void main() {
  initializeFirebaseConfig();

}
void initializeFirebaseConfig() async {
  const firebaseOptions =  FirebaseOptions(
      apiKey: "AIzaSyB-6Afdr4fKTr_04462dqie0CCLGknXPGY",
      authDomain: "tradepro-7abc6.firebaseapp.com",
      projectId: "tradepro-7abc6",
      storageBucket: "tradepro-7abc6.appspot.com",
      messagingSenderId: "392539270707",
      appId: "1:392539270707:web:898cfd015d6fdc24c6bd46",
      measurementId: "G-20ZPC56BGV");/*const FirebaseOptions(
              apiKey: "AIzaSyBnnWfZMD7olNkN_7DGtJqO_SyjOqMYWb4",
              appId: "1:122593195327:android:d177d33bd7702790db8f8a",
              messagingSenderId: "122593195327",
              projectId: "max-vams2");*/
  await Firebase.initializeApp(options: firebaseOptions);
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          title: 'Trade Pro',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: RouteName.splash_route,
          //initial page of this application
          routes: routes,
        );
      });
    });
  }

}
