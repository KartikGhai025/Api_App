import 'dart:convert';

import 'package:http/http.dart' as http;
String apikey='6d5c8b3058875d4a1e6271647fba2abe';
class ApiService {
  Future<List<dynamic>?> getTracks() async {
    var client = http.Client();
    var url = Uri.parse(
        'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=$apikey');

    var response = await client.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      Map<String, dynamic> data = map["message"]['body'];
      List<dynamic> tracks = data['track_list'];

      return tracks;
    }
  }

  getTrackDetail(String id) async {
    var client = http.Client();
    var url = Uri.parse(
        'https://api.musixmatch.com/ws/1.1/track.get?track_id=${id}&apikey=$apikey');

    var response = await client.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      Map<String, dynamic> data = map["message"]['body']['track'];
      print(data.runtimeType);
return data;
    }
  }

  Future getLyrics(String id)async{

    var client = http.Client();
    var url = Uri.parse(
        'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${id}&apikey=$apikey'); //Api-C

    var response = await client.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      Map<String, dynamic> data = map["message"]['body']['lyrics'];
      print(data['lyrics_body']);

        return data['lyrics_body'];

    }
  }
}
