import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class Marvel {
  /*
  ts - a timestamp (or other long string which can change on a request-by-request basis)
hash - a md5 digest of the ts parameter, your private key and your public key (e.g. md5(ts+privateKey+publicKey)
For example, a user with a public key of "1234" and a private key of "abcd" could construct a valid call as follows:
 http://gateway.marvel.com/v1/public/comics?ts=1&apikey=1234&hash=ffd275c5130566a2916217b101f26150 (the hash value is the md5 digest of 1abcd1234)
   */
  String publicKey = '9d643917f4fd01ed325d3b835cf53a62';

  String privateKey = '3e5927b2a5eb6a65b19a4d416187b6daef146ae1';

  String baseEndPoint = 'http://gateway.marvel.com/v1/public/characters';

  String comicEndPoint = 'http://gateway.marvel.com/v1/public/comics';

  int timestamp = DateTime.now().millisecondsSinceEpoch;

  String getTimeStamp() {
    return timestamp.toString();
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  String generateHash(String ts, String publicApi, String privateApi) {
    return generateMd5(ts + privateApi + publicApi);
  }

  String generatedUrl(int offset) {
    return baseEndPoint +
        '?ts=' +
        getTimeStamp() +
        '&apikey=' +
        publicKey +
        '&hash=' +
        generateHash(getTimeStamp(), publicKey, privateKey) +
        '&limit=10&offset=' +
        offset.toString();
  }

  String generateComicURL(int ID, int available) {
    return baseEndPoint +
        '/' +
        ID.toString() +
        '/comics' +
        '?ts=' +
        getTimeStamp() +
        '&apikey=' +
        publicKey +
        '&hash=' +
        generateHash(getTimeStamp(), publicKey, privateKey) +
        '&limit=' +
        available.toString();
  }

  String generateComicInfoURL(int id) {
    return comicEndPoint +
        '/' +
        id.toString() +
        '?ts=' +
        getTimeStamp() +
        '&apikey=' +
        publicKey +
        '&hash=' +
        generateHash(getTimeStamp(), publicKey, privateKey);
  }

  Future<String> getData(int offset) async {
    http.Response response = await http.get(generatedUrl(offset));
    String data = response.body;
    print('Character Data:' + response.statusCode.toString());
    return data;
  }

  Future<String> getComicData(int characterId, int available) async {
    http.Response response =
        await http.get(generateComicURL(characterId, available));
    String data = response.body;
    print('Comics Data:' + response.statusCode.toString());
    return data;
  }

  Future<String> getComicInfoData(int id) async {
    http.Response response = await http.get(generateComicInfoURL(id));
    String data = response.body;
    print('Comic Info Data: ' + response.statusCode.toString());
    return data;
  }

  String getCharacterName(String data, int index) {
    try {
      return jsonDecode(data)['data']['results'][index]['name'];
    } catch (e) {
      print(e);
      return 'No Name';
    }
  }

  String getCharacterDescription(String data, int index) {
    //data.results[5].description
    try {
      return jsonDecode(data)['data']['results'][index]['description'];
    } catch (e) {
      print(e);
      return 'No Description';
    }
  }

  String getImageUrl(String data, int index) {
    //data.results[5].thumbnail.path
    // data.results[5].thumbnail.extension
    try {
      return jsonDecode(data)['data']['results'][index]['thumbnail']['path'] +
          '/portrait_incredible.' +
          jsonDecode(data)['data']['results'][index]['thumbnail']['extension'];
    } catch (e) {
      print(e);
      return 'https://i.pinimg.com/564x/e4/3b/0d/e43b0d16c8615c9c4cb357c75e8d9741.jpg';
    }
  }

  String getComicImageURL(String data, int noOfComic) {
    //data.results[0].images[0].path
    try {
      return jsonDecode(data)['data']['results'][noOfComic]['images'][0]
              ['path'] +
          '/portrait_incredible.' +
          jsonDecode(data)['data']['results'][noOfComic]['images'][0]
              ['extension'];
    } catch (e) {
      print(e);
      return 'https://i.pinimg.com/564x/e4/3b/0d/e43b0d16c8615c9c4cb357c75e8d9741.jpg';
    }
  }

  int getCharacterID(String data, int index) {
    // data.results[6].id
    try {
      return jsonDecode(data)['data']['results'][index]['id'];
    } catch (e) {
      print(e);
      return 0;
    }
  }

  int getAvailableComic(String data, int index) {
    //data.results[6].comics.available
    try {
      return jsonDecode(data)['data']['results'][index]['comics']['available'];
    } catch (e) {
      print(e);
      return 0;
    }
  }

  String getComicTitle(String data, int comicIndex) {
    //data.results[0].title data.results[1].id
    try {
      return jsonDecode(data)['data']['results'][comicIndex]['title'];
    } catch (e) {
      print(e);
      return 'Comic #' + (comicIndex + 1).toString();
    }
  }

  String getComicDescription(String data, int comicIndex) {
    //data.results[0].description
    try {
      return jsonDecode(data)['data']['results'][comicIndex]['description'];
    } catch (e) {
      print(e);
      return 'No Description';
    }
  }

  int getComicIDFromCharacter(String data, int index) {
    //data.results[0].id
    try {
      return jsonDecode(data)['data']['results'][index]['id'];
    } catch (e) {
      return 0;
    }
  }

  int getComicPrintPrice(String data, int index) {
    //data.results[0].prices[0].price
    try {
      return jsonDecode(data)['results'][0]['prices'][0]['price'];
    } catch (e) {
      return 0;
    }
  }
}
