import 'dart:convert';

import 'package:api_app/services/api_service.dart';
import 'package:api_app/views/detailpage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'lyrics_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic>? tracks;
  bool isLoaded = false;
  late String lyrics;
  int? len;
  late Map<String, dynamic> data;
  @override
  void initState() {
    super.initState();
    checkRealtimeConnection();
    Getdata();
  }

  Future Getdata() async {

    tracks = await ApiService().getTracks();

    if (tracks != null) {
      setState(() {
        isLoaded = true;
        len = tracks?.length;
      });
    }
  }

  bool notInternet = false;
  final _connectivity = Connectivity();
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
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[400],
          title: Text('Tracks'),
          centerTitle: true,
        ),
        body: notInternet
            ? Container(
                child: Center(child: Text('No Internet Connection 😕')),
              )
            : Visibility(
                visible: isLoaded,
                replacement: Center(child: CircularProgressIndicator()),
                child: AnimationLimiter(
                  child: ListView.builder(
                    padding: EdgeInsets.all(_w / 30),
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: len,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        delay: Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          horizontalOffset: -300,
                          verticalOffset: -850,
                          child: MaterialButton(
                            onPressed: () async {
                              lyrics = await ApiService().getLyrics(
                                  tracks![index]['track']['track_id']
                                      .toString());
                              data = await ApiService().getTrackDetail(
                                  tracks![index]['track']['track_id']
                                      .toString());

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                        lyrics: lyrics,
                                        data: data,
                                      )));
                            },
                            child: Container(
                              padding: EdgeInsets.all(_w / 30),
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: _w / 20),
                              height: _w / 3.5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.music_note,
                                    color: Colors.red[400],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: _w * 0.55,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            style: TextStyle(fontSize: 18),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            "- " +
                                                '${tracks![index]['track']['track_name']}'),
                                        Text(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            tracks![index]['track']
                                                    ['album_name']
                                                .toString()),
                                        Text('by ' +
                                            tracks![index]['track']
                                                ['artist_name'])
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        lyrics = await ApiService().getLyrics(
                                            tracks![index]['track']['track_id']
                                                .toString());
                                       showLyrics(lyrics, context);
                                      },
                                      icon: Icon(
                                        Icons.arrow_upward,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ));
  }
}
