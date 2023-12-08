import 'dart:convert';
import 'package:ct484_project/models/chapter.dart';
import 'package:http/http.dart' as http;
import '../models/auth_token.dart';
import 'firebase_service.dart';

class ChaptersService extends FirebaseService {
  ChaptersService([AuthToken? authToken]) : super(authToken);

  fetchChapters(String novelId) async {
    final chapters = Chapter(chapterCount: 0, chapterContent: []);

    try {
      final userLibrarysUrl =
          Uri.parse('$databaseUrl/chapter/$novelId.json?auth=$token');
      final userLibrarysResponse = await http.get(userLibrarysUrl);
      final userLibrarysMap = json.decode(userLibrarysResponse.body);
      userLibrarysMap.forEach((chapter) {
        if (chapter != null) {
          chapters.addChapterContent(jsonEncode(chapter));
        }
      });
      return chapters;
    } catch (error) {
      print(error);
      return chapters;
    }
  }
}
