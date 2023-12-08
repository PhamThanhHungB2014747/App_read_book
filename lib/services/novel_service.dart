import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/novel.dart';
import '../models/auth_token.dart';
import 'firebase_service.dart';

class NovelsService extends FirebaseService {
  NovelsService([AuthToken? authToken]) : super(authToken);

  Future<List<Novel>> fetchNovels([bool filterByUser = false]) async {
    final List<Novel> novels = [];

    try {
      final filters =
          filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      final novelsUrl =
          Uri.parse('$databaseUrl/novels.json?auth=$token&$filters');
      final response = await http.get(novelsUrl);
      final novelsMap = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print(novelsMap['error']);
        return novels;
      }

      final userLibrarysUrl =
          Uri.parse('$databaseUrl/userLibrarys/$userId.json?auth=$token');
      final userLibrarysResponse = await http.get(userLibrarysUrl);
      final userLibrarysMap = json.decode(userLibrarysResponse.body);

      novelsMap.forEach((novelId, novel) {
        final inLibrary = (userLibrarysMap == null)
            ? false
            : (userLibrarysMap[novelId] ?? false);

        novels.add(
          Novel.fromJson({
            'id': novelId,
            ...novel,
          }).copyWith(inLibrary: inLibrary),
        );
      });
      return novels;
    } catch (error) {
      print(error);
      return novels;
    }
  }

  Future<Novel?> addNovel(Novel novel) async {
    try {
      final Url = Uri.parse('$databaseUrl/novels.json?auth=$token');
      final response = await http.post(
        Url,
        body: json.encode(
          novel.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return novel.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updateNovel(Novel novel) async {
    try {
      final url = Uri.parse('$databaseUrl/novels/${novel.id}.json?auth=$token');
      // print(novel.countChapter);
      final response = await http.patch(
        url,
        body: json.encode(novel.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteNovel(String id) async {
    try {
      final url = Uri.parse('$databaseUrl/novels/$id.json?auth=$token');
      final response = await http.delete(url);

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> saveLibraryStatus(Novel novel) async {
    try {
      final url = Uri.parse(
          '$databaseUrl/userLibrarys/$userId/${novel.id}.json?auth=$token');
      final response = await http.put(
        url,
        body: json.encode(
          novel.inLibrary,
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
