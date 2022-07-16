import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'views/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool notInternet = false;
  final connectivity = Connectivity();

  checkRealtimeConnection() {

    connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile) {
        notInternet = false;
      } else if (event == ConnectivityResult.wifi) {
        notInternet = false;
      } else {
        notInternet = true;

      }
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    checkRealtimeConnection();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:
      notInternet? Material(
        child: Center(child: Text('No Internet Connection 😕')),
      ):
       MyHomePage(),



    );
  }
}
