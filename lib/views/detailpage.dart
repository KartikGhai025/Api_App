import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  Map<String, dynamic> data;
  String lyrics;
  DetailPage({Key? key, required this.lyrics, required this.data})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool notInternet = false;

  var _connectivity = Connectivity();

  checkRealtimeConnection() {
    _connectivity.onConnectivityChanged.listen((event) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Details'),
        centerTitle: true,
        backgroundColor: Colors.red[400],
      ),
      body: notInternet
          ? Center(child: Text('No Internet Connection 😕'))
          : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
                children: [
                  Text('Name:',style: HeadText(),),
                  Text(widget.data['track_name'], style: MainText()),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Album:',style: HeadText(),),
                  Text(
                    widget.data['album_name'],
                    style: MainText(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Ratings:",style: HeadText(),),
                  Text(
                    widget.data['track_rating'].toString() + ' %',
                    style: MainText(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Artist:',style: HeadText(),),
                  Text(
                    widget.data['artist_name'],
                    style: MainText(),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Center(child: Text('____Lyrics____',style: HeadText(),)),
                  SizedBox(height: 5,),
                  Text(widget.lyrics,style: HeadText(),)
                ],
              ),
          ),
    );
  }
}

TextStyle MainText() {
  return TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
}
TextStyle HeadText() {
  return TextStyle(fontWeight: FontWeight.w500 ,
      fontSize: 15);
}
