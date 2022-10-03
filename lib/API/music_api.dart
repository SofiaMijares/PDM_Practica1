import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class APIRepository {
  static final APIRepository _singleton = APIRepository._internal();

  factory APIRepository() {
    return _singleton;
  }

  APIRepository._internal();

  Future<dynamic> findSong(String path) async { 
    
    var request =  http.MultipartRequest('POST', Uri.parse('https://api.audd.io/'));
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      File(path).readAsBytesSync(),
      filename: 'music.m4a',
    ));
    request.fields['api_token'] = '93e9fc0f6dffe5c83f5b6275aa525ad3';
    request.fields['return'] = 'apple_music,spotify';
    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    final res = jsonDecode(responseString);
    print(res);
    if (res['status'] == 'success') {
      if (res['result'] != null) {
        var result = res['result'];
        var title = result['title'];
        var album = result['spotify']['album']['name'];
        var image = result['spotify']['album']['images'][1]['url'];
        var releaseDate = result['release_date'];
        var artist = result['artist'];
        var apple = result['apple_music']['url'];
        var spotify = result['spotify']['album']['external_urls']['spotify'];
        var songLink = result['song_link'];
    return {
      'title': title,
      'album': album,
      'image': image,
      'release_date': releaseDate,
      'artist': artist,
      'apple': apple,
      'spotify': spotify,
      'song_link': songLink,
    };
      } else {
        return "No hay registro de la canción";
      }
    } else {
      return "ERROR";
    }
  }
}