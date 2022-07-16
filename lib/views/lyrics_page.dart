import 'package:flutter/material.dart';

showLyrics(String lyrics, BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    barrierColor: Colors.transparent.withOpacity(0.5),
    backgroundColor: Colors.white,
    elevation: 1000,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: ListView(
            children: <Widget>[
              Center(
                child: Text('Lyrics',
                style: TextStyle(
                  color: Colors.red[400]
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  lyrics,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
